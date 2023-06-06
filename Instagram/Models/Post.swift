//
//  Post.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 11/05/23.
//


import Foundation

struct Post: Hashable, Codable {
    let username: String
    let image: String
    let posted_at: String
    let caption: String
    let location: String?
    let isSponsored: Bool?
    let isLiked: Bool?
    var likes: Int {
        Int(arc4random_uniform(1000))
    }
    var comments: Int {
        Int(arc4random_uniform(100))
    }
    var user: User {
        users.first(where: { _user in
            _user.username == username
        })!
    }
}
