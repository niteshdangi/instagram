//
//  CommentScreen.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 14/05/23.
//

import SwiftUI

struct CommentScreen: View {
    var post: Post
    var body: some View{
        VStack(spacing: 0) {
            Divider()
            ScrollView {
                VStack(spacing: 0){
                    HStack {
                        ProfilePhoto(user: post.user)
                            .frame(width: 45, height: 45)
                        VStack(alignment: .leading) {
                            Text("\(post.username)  ")
                                .bold() +
                            Text(post.posted_at.replacing(" ago", with: ""))
                                .foregroundColor(.secondary)
                            Text(post.caption)
                                .font(.callout)
                        }
                        Spacer()
                    }
                    .padding(10)
                    Divider()
                }
            }
            Divider()
            HStack(spacing: 15) {
                ForEach("❤️🙌🔥👏😢😍😮😂".split(separator: ""), id: \.self) {emoji in
                    Text(emoji)
                        .font(.title)
                }
            }
            .padding([.bottom, .top], 15)
            HStack {
                ProfilePhoto(user: currentUser, showStoryBorder: false)
                    .frame(width: 45, height: 45)
                HStack{
                    Text("Add a comment for \(post.username)")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding( 10)
                .overlay(
                    RoundedRectangle(cornerRadius: .infinity)
                        .stroke(.secondary, lineWidth: 1)
                )
            }
            .padding([.trailing, .leading])
        }
        .navigationTitle("Comments")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "paperplane")
            }
        }
        .toolbarBackground(.automatic, for: .navigationBar)
        .toolbarColorScheme(.light, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
}
