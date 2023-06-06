//
//  Users.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 10/05/23.
//

import Foundation
import SwiftUI

struct User: Hashable, Codable {
    let username: String
    let fullName: String
    let followers: Int
    let following: Int
    let posts: Int
    let bio: String
    let location: String
    let website: String
    let email: String
    let phone: String
    let dob: String
    let joinedDate: String
    let isVerified: Bool
    let image: String
    var storyAvailable: Bool? = false
    var storyViewed: Bool? = false
    let isFollowing: Bool?
    let isFollower: Bool?
    let isOnline: Bool?
    
    var isCurrent: Bool {
        username == "niteshdangi"
    }
}
