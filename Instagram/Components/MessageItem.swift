//
//  MessageItem.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 13/05/23.
//

import SwiftUI

struct MessageItem: View{
    var message: Message
    var body: some View {
        HStack(alignment: .center) {
            MessageItemProfilePhoto(message: message)
            VStack(alignment: .leading, spacing: 0) {
                Text(message.user?.fullName ?? (message.group_info?.groupName)!)
                    .frame(width: .infinity, height: 20)
                    .fontWeight(message.unread_count > 0 ? .semibold : .regular)
                HStack {
                    if(!(message.last_message.user?.isCurrent)!){
                        Text(message.last_message.message)
                            .frame(width: .infinity, height: 20)
                            .fontWeight(message.unread_count > 0 ? .semibold : .regular)
                            .foregroundColor(message.unread_count > 0 ? .black : .secondary)
                        Text(message.last_message.time)
                            .foregroundColor(.secondary)
                    }
                    else {
                        Text("\(message.last_message.seen ?? false ? "Seen" : "Sent") \(message.last_message.time) ago")
                            .frame(width: .infinity, height: 20)
                            .fontWeight(message.unread_count > 0 ? .semibold : .regular)
                            .foregroundColor(.secondary)
                    }
                }
            }
            Spacer()
            HStack {
                if(message.unread_count > 0){
                    HStack {}
                        .frame(width: 10, height: 10)
                        .background(.blue)
                        .cornerRadius(.infinity)
                        .padding([.trailing], 3)
                }
                Image(systemName: "camera")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(message.unread_count > 0 ? .black : .secondary)
            }
            .padding([.leading], 5)
        }
        .padding([.leading, .trailing])
    }
}

struct MessageItemProfilePhoto: View {
    var message: Message
    var width: CGFloat = 60
    var height: CGFloat = 60
    var body: some View {
        if(message.type == "user" && message.user != nil){
            ProfilePhoto(user: message.user!)
                .frame(width: width, height: height)
        }
        if(message.type == "group" && message.group_info != nil){
            if(message.group_info?.image != nil){
                AsyncImage(
                    url: URL(string: (message.group_info?.image)!)
                ) { image in
                    image.resizable()
                } placeholder: {
                    HStack {
                        Spacer()
                    }
                    .frame(width: width, height: height)
                    .background(.gray)
                    .cornerRadius(.infinity)
                }
                .cornerRadius(.infinity)
                .frame(width: width, height: height)
            }
            else{
                ZStack(alignment: .bottomTrailing) {
                    ProfilePhoto(user: (message.group_info?.userlist[0])!, showStoryBorder: false)
                        .frame(width: width * 0.75, height: height * 0.75)
                        .padding([.trailing], width * 0.25)
                        .padding([.bottom], height * 0.25)
                    
                    ProfilePhoto(user: (message.group_info?.userlist[0])!, showStoryBorder: false)
                        .frame(width: width * 0.75, height: height * 0.75)
                        .padding(2)
                        .background(.white)
                        .cornerRadius(.infinity)
                }
            }
        }
    }
}
