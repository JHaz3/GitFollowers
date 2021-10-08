//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Jake Haslam on 10/7/21.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
}
