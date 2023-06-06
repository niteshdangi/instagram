//
//  ChatScreen.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 14/05/23.
//

import SwiftUI

struct ChatScreen: View{
    var message: Message
    
    var body: some View {
        ZStack {
            AsyncImage(
                url: URL(string: "https://source.unsplash.com/200x1000/?theme,gradient,light-blue,white,yellow,beach")
            ) { image in
                image.image?.resizable()
            }
            .frame(width: .infinity, height: .infinity)
            .edgesIgnoringSafeArea([.top, .bottom])
            
            VStack{
                ScrollView{
                    if(message.type == "user"){
                        VStack{
                            ProfilePhoto(user: message.user!, showStoryBorder: false)
                                .frame(width: 120, height: 120)
                                .padding(20)
                            Text((message.user?.fullName)!)
                                .fontWeight(.bold)
                            
                            Text("\((message.user?.username)!) ·  Instagram")
                                .foregroundColor(.secondary)
                            Text("\((message.user?.followers)!) followers ·  \((message.user?.posts)!) posts")
                                .foregroundColor(.secondary)
                            
                            Text(message.user?.isFollower ?? false && message.user?.isFollowing ?? false ? "You both follow each other on Instagram" : "You dont follow each other on Intagram")
                            .foregroundColor(.secondary)
                            Button(action: {}){
                                Text("View Profile")
                                    .foregroundColor(.black)
                            }
                            .padding(6)
                            .background(.secondary.opacity(0.5))
                            .cornerRadius(8)
                        }
                    }
                    else {
                        VStack{
                            MessageItemProfilePhoto(message: message, width: 120, height: 120)
                                .padding(20)
                            Text((message.group_info?.userlist)!.map { $0.username } .joined(separator: ", "))
                                .fontWeight(.bold)
                            Button(action: {}){
                                Text("View Group Members")
                                    .foregroundColor(.black)
                            }
                            .padding(6)
                            .background(.secondary.opacity(0.5))
                            .cornerRadius(8)
                        }
                    }
                }
                HStack {
                    Image(systemName: "camera.fill")
                        .padding([.top, .bottom] ,7)
                        .padding([.leading, .trailing] ,5)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(.infinity)
                    Text("Message...")
                    Spacer()
                    Image(systemName: "mic.fill")
                    Image(systemName: "photo.fill")
                    Image(systemName: "face.smiling.fill")
                        .padding([.trailing], 10)
                }
                .padding(5)
                .background(.secondary.opacity(0.5))
                .cornerRadius(.infinity)
                .padding([.leading, .trailing], 15)
                .padding([.bottom])
            }
            .shadow(color: .white, radius: 1)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    MessageItemProfilePhoto(message: message, width: 40, height: 40)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(message.user?.fullName ?? (message.group_info?.groupName)!)
                            .frame(height: 20)
                            .frame(maxWidth: 200)
                            .fontWeight(.bold)
                        if(message.username != nil){
                            Text(message.username!)
                                .frame(width: .infinity, height: 20)
                        }
                    }
                }
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                HStack(spacing: 15) {
                    Image(systemName: "phone")
                    Image(systemName: "video")
                }
            }
            
        }
    }
}
