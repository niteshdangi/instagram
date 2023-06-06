//
//  Home.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 10/05/23.
//

import SwiftUI

struct HomeScreen: View {
    var goTo: (String) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack{
                Image("Instagram")
                    .resizable()
                    .frame(width: 120, height: 40)
                Spacer()
                Image(systemName: "heart")
                    .font(.title2)
                    .padding([.trailing], 5)
                Button(action: {goTo("messages")}){
                    Image(systemName: "message")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
            .padding([.leading, .trailing], 20)
            
            ScrollView {
                VStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack{
                            ForEach(
                                users.sorted(
                                    by: {
                                        !($0.storyViewed ?? false) && ($1.storyViewed ?? false) ||
                                        ($0.isCurrent ) && !($1.isCurrent )
                                    })
                                .filter({ user in
                                    return (user.storyAvailable ?? false) || user.isCurrent
                                }), id: \.self){user in
                                    VStack {
                                        ProfilePhoto(user: user, showPlus: user.isCurrent, action: {
                                            if(user.isCurrent){
                                                goTo("camera")
                                            }
                                        })
                                        .frame(width: 80, height: 80)
                                        Text(user.isCurrent ? "Your Story" : user.username)
                                            .font(.caption)
                                            .frame(maxWidth: 80)
                                            .foregroundColor(user.isCurrent ? .secondary : .black)
                                    }
                                    
                                }
                        }
                        .padding([.leading, .trailing], 10)
                    }
                }
                .padding([.top], 10)
                Divider()
                    .padding([.top, .bottom], 3)
                LazyVStack{
                    ForEach(posts, id: \.self){post in
                        FeedPostView(post: post)
                    }
                }
            }
            
            Divider()
                .padding([.bottom], 55)
        }
    }
}
