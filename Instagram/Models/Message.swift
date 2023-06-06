//
//  Message.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 13/05/23.
//

import Foundation

struct GroupInfo: Hashable, Codable {
    let name: String?
    let image: String?
    let usernames: [String]
    
    var userlist: [User] {
        users.filter({ user in
            usernames.contains(user.username)
        })
    }
    
    var allUserNames: String {
        let names = userlist.map { $0.fullName }
        return names.joined(separator: ", ")
    }
    var groupName: String {
        if(name != nil){
            return name!
        }
        return allUserNames
    }
}


struct LastMessage: Hashable, Codable {
    let username: String
    let message: String
    let time:String
    let seen: Bool?
    
    var user: User? {
        users.first(where: { _user in
            _user.username == username
        })!
    }
}


struct Message: Hashable, Codable {
    let type: String
    let username: String?
    let group_info: GroupInfo?
    let unread_count: Int
    let last_message: LastMessage
    
    var user: User? {
        if username != nil {
            return users.first(where: { _user in
                _user.username == username
            })!
        }
        return nil
    }
}
