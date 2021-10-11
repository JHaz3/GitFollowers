//
//  NetworkController.swift
//  GitHubFollowers
//
//  Created by Jake Haslam on 10/7/21.
//

import UIKit

class NetworkController {
    
    // MARK: - Properties
    fileprivate let baseUrl = "https://api.github.com/users/"
    
    static let shared = NetworkController()
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], NetworkError>) -> Void) {
        
        let baseUrl = baseUrl + "\(username)/followers?per_Page=100&page=\(page)"
        
        guard let finalUrl = URL(string: baseUrl) else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: finalUrl) { data, _, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---/n \(error)")
                return completion(.failure(.thrown(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---/n \(error)")
                completion(.failure(.thrown(error)))
            }
        } .resume()
        
    }
    
    func getUserInfo(for username: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
        
        let baseUrl = baseUrl + "\(username)"
        
        guard let finalUrl = URL(string: baseUrl) else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: finalUrl) { data, response, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---/n \(error)")
                return completion(.failure(.thrown(error)))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---/n \(error)")
                completion(.failure(.thrown(error)))
            }
        } .resume()
        
    }
    
    func fetchAvatarImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
            
        } .resume()
    }
    
}// End of Class
