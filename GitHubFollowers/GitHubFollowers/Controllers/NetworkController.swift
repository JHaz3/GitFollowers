//
//  NetworkController.swift
//  GitHubFollowers
//
//  Created by Jake Haslam on 10/7/21.
//

import UIKit

class NetworkController {
    
    // MARK: - Properties
    private let baseURL = "https://api.github.com/users/"
    
    static let shared = NetworkController()
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    
    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badData
        }
        
        do {
            return try decoder.decode([Follower].self, from: data)
        } catch {
            throw NetworkError.badData
        }
    }
    
    func getUserInfo(for username: String) async throws -> User {
        let endpoint = baseURL + "\(username)"
        guard let url = URL(string: endpoint) else { throw NetworkError.invalidURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NetworkError.invalidURL }
        
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            throw NetworkError.badData
        }
    }
    
    func fetchAvatarImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}// End of Class
