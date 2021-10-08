//
//  NetworkController.swift
//  GitHubFollowers
//
//  Created by Jake Haslam on 10/7/21.
//

import Foundation

class NetworkController {
    
    // MARK: - Properties
    fileprivate let baseUrl = "https://api.github.com/users/"
    
    static let shared = NetworkController()
    
    private init() {}
    
    
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], NetworkError>) -> Void) {
        
        let baseUrl = baseUrl + "\(username)/followers?per_Page=100&page=\(page)"
        
        guard let finalUrl = URL(string: baseUrl) else { return completion(.failure(.invalidURL)) }
        
        let task = URLSession.shared.dataTask(with: finalUrl) { data, _, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---/n \(error)")
                return completion(.failure(.noData))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---/n \(error)")
                return completion(.failure(.noData))
            }
        }
        task.resume()
    }
}// End of Class
