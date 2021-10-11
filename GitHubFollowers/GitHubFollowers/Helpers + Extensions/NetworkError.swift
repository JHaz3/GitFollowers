//
//  NetworkError.swift
//  GitHubFollowers
//
//  Created by Jake Haslam on 10/7/21.
//

import Foundation

enum NetworkError: LocalizedError, Error {
case thrown(Error)
case invalidURL
case noData
case badData
case unableToDelete
case unableToFavorite
case alreadyInFavorites
    
    var errorDescription: String? {
        switch self {
        case .thrown(let error):
            return error.localizedDescription
        case .invalidURL:
            return "Unable to reach server"
        case .noData:
            return "Server responded with no data."
        case .badData:
            return "Server responded with bad data."
        case .unableToDelete:
            return "Mission Failed"
        case .unableToFavorite:
            return "There was an error favoriting this user, please try again"
        case .alreadyInFavorites:
            return "You've already favorited this user. You must be their biggest fan!"
        }
    }
}
