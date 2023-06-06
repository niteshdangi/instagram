//
//  FeedPostView.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 11/05/23.
//

import SwiftUI

struct FeedPostView: View {
    var post: Post
    @State var likedAnim: Bool = false
    @State var savedAnim: Bool = false
    @State var likes: Int = 0
    @State var isLiked: Bool = false
    @State var isSaved: Bool = false
    @State var isShareSheetOpen: Bool = false
    @State var showingOptions: Bool = false
    @State var comments: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                ProfilePhoto(user: post.user)
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading){
                    Text(post.username)
                        .fontWeight(.semibold)
                    if post.isSponsored ?? false {
                        Text("Sponsored")
                            .font(.subheadline)
                    }
                    else if (post.location != nil) {
                        Text(post.location!)
                            .font(.subheadline)
                    }
                }
                .padding([.leading], 4)
                Spacer()
                if !(post.user.isFollowing ?? false) {
                    Button(action: {}){
                        Text((post.user.isFollower ?? false) ? "Follow Back" : "Follow")
                            .foregroundColor(.black)
                            .padding([.top, .bottom], 3)
                            .padding([.leading, .trailing], 10)
                    }
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .padding([.trailing], 5)
                }
                if(post.isSponsored ?? false) {
                    Image(systemName: "ellipsis")
                        .onTapGesture {
                            showingOptions.toggle()
                        }
                        .confirmationDialog("", isPresented: $showingOptions, titleVisibility: .hidden) {
                            ForEach(["Hide ad", "Report ad", "Why you're seeing this ad", "About this account", "About Instagram ads"], id: \.self) { option in
                                Button(option, role: ["Hide ad", "Report ad"].contains(where: {_opt in
                                    _opt == option
                                }) ? .destructive : nil ) {
                                    
                                }
                            }
                        }
                }
                else{
                    Image(systemName: "ellipsis")
                        .onTapGesture {
                            showingOptions.toggle()
                        }
                        .sheet(isPresented: $showingOptions) {
                            PostOptionSheet(isOpen: $showingOptions, onSave: onSave)
                        }
                }
            }
            .padding([.leading, .bottom], 10)
            .padding([.trailing], 20)
            Divider()
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: post.image)) { image in
                    image.resizable()
                } placeholder: {
                    HStack {
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.gray)
                }
                .overlay(
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 90, height: 90, alignment: .center)
                        .foregroundColor(.white)
                        .opacity(self.likedAnim ? 0.8 : 0)
                        .scaleEffect(self.likedAnim ? 1.0 : 0)
                        .animation(.easeIn, value: likedAnim)
                ).onTapGesture(count: 2) {
                    self.likedAnim.toggle()
                    self.isLiked.toggle()
                    let impactHeavy = UIImpactFeedbackGenerator(style: .medium)
                    impactHeavy.impactOccurred()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.7) {
                        self.likedAnim.toggle()
                    }
                }
                if(savedAnim){
                    HStack {
                        Button(action: {}){
                            Text("Save to collection")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .padding(10)
                    .background(.white)
                    .transition(.opacity)
                }
            }
            .frame(height: 400)
            .frame(minWidth: 0, maxWidth: .infinity)
            Divider()
            HStack(spacing: 17){
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(isLiked ? .red : .black)
                    .animation(.easeIn, value: likedAnim)
                    .onTapGesture(count: 1) {
                        self.likedAnim.toggle()
                        self.isLiked.toggle()
                        let impactHeavy = UIImpactFeedbackGenerator(style: .medium)
                        impactHeavy.impactOccurred()
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.7) {
                            self.likedAnim.toggle()
                        }
                    }
                NavigationLink {
                    CommentScreen(post: post)
                } label: {
                    Image(systemName: "message")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.black)
                        .navigationTitle("")
                }
                Image(systemName: "paperplane")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .onTapGesture {
                        isShareSheetOpen.toggle()
                    }
                    .sheet(isPresented: $isShareSheetOpen, content: {
                        ShareSheet(isShareSheetOpen: $isShareSheetOpen, post: post)
                    })
                Spacer()
                Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                    .resizable()
                    .frame(width: 20, height: 22)
                    .onTapGesture {
                        onSave()
                    }
            }
            .padding(10)
            .padding([.trailing], 10)
            Text("\(String(likes)) likes")
                .padding([.leading], 10)
                .fontWeight(.semibold)
            HStack {
                Text("\(post.username) ")
                    .bold() +
                Text(post.caption)
            }
            .padding([.leading, .trailing], 10)
            
            Text("View all \(String(comments)) comments")
                .padding([.leading], 10)
                .foregroundColor(.gray)
                .padding([.top, .bottom], 5)
            if !(post.isSponsored ?? false) {
                Text(post.posted_at)
                    .padding([.leading], 10)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
        .padding([.bottom], 10)
        .onAppear {
            likes = post.likes
            comments = post.comments
            isLiked = post.isLiked ?? false
        }
    }
    func onSave(){
        if(!isSaved){
            withAnimation {
                savedAnim.toggle()
            }
        }
        isSaved.toggle()
        let impactHeavy = UIImpactFeedbackGenerator(style: .medium)
        impactHeavy.impactOccurred()
        if(isSaved){
            withAnimation{
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    withAnimation{
                        savedAnim.toggle()
                    }
                }
            }
        }
    }
}


