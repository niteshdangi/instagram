//
//  MessagesScreen.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 11/05/23.
//

import SwiftUI

struct MessagesScreen: View {
    var goHome: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Button(action: goHome){
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Text(currentUser.username)
                    .font(.title)
                    .fontWeight(.semibold)
                Image(systemName: "chevron.down")
                    .font(.body)
                Spacer()
                Image(systemName: "video")
                    .resizable()
                    .frame(width: 25, height: 17)
                    .padding([.trailing], 5)
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .frame(width: 20, height: 19)
            }
            .padding([.leading, .trailing, .top], 15)
            ScrollView {
                Section{
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black.opacity(0.6))
                        Text("Search")
                            .foregroundColor(.black.opacity(0.6))
                        Spacer()
                    }
                    .padding(8)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(8)
                }
                .padding([.leading, .trailing], 10)
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 20){
                        ForEach(users.sorted(
                            by: {
                                ($0.isCurrent ) && !($1.isCurrent )
                            })
                            .filter({ user in
                                return (user.isOnline ?? false) || user.isCurrent
                            }), id: \.self) { user in
                                VStack {
                                    ProfilePhoto(user: user, showActiveStatus: !user.isCurrent)
                                        .frame(width: 85, height: 85)
                                    Text(user.isCurrent ? "Your Note" : user.username)
                                        .font(.caption)
                                        .frame(maxWidth: 85)
                                        .foregroundColor(user.isCurrent ? .secondary : .black)
                                }
                            }
                    }
                    .padding([.leading, .top])
                }
                HStack {
                    Text("Messages")
                        .fontWeight(.bold)
                    Spacer()
                    Text("Requests")
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                        .font(.subheadline)
                }
                .padding([.trailing, .leading])
                .padding([.top, .bottom], 10)
                LazyVStack(spacing: 15) {
                    ForEach(messages, id: \.self){ message in
                        NavigationLink {
                            ChatScreen(message: message)
                        } label: {
                            MessageItem(message: message)
                        }
                        .navigationTitle("")
                    }
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}
