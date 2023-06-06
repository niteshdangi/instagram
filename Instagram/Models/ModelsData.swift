//
//  ModelsData.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 11/05/23.
//

import Foundation

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}


var users: [User] = load("Users.json")
var currentUser: User = users.first(where: {user in user.isCurrent})!
var posts: [Post] = load("Posts.json")
var messages: [Message] = load("Messages.json")
var explorePosts: [Explore] = load("Explore.json")
