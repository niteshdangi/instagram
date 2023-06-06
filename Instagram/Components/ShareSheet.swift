//
//  ShareSheet.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 14/05/23.
//

import SwiftUI


var shareIcons = ["square.and.arrow.up", "link", "message", "whatsapp", "plus.message"]
var shareName = ["Share to...", "Copy link", "Message", "Whatsapp", "Messenger"]

struct ShareSheet: View {
    @Binding var isShareSheetOpen: Bool
    var post: Post
    @State var selectedUsers: [String] = []
    
    var body: some View{
        VStack(spacing: 0){
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black.opacity(0.6))
                Text("Search")
                    .foregroundColor(.black.opacity(0.6))
                Spacer()
                Image(systemName: "person.2")
                    .foregroundColor(.black.opacity(0.6))
            }
            .padding(8)
            .background(.gray.opacity(0.2))
            .cornerRadius(8)
            .padding([.leading, .trailing], 15)
            .padding([.top], 25)
            .padding([.bottom], 4)
            ScrollView {
                LazyVStack(spacing: 15){
                    HStack{
                        ProfilePhoto(user: currentUser, showStoryBorder: false)
                            .frame(width: 50, height: 50)
                            .padding([.trailing], 10)
                        Text("Add Post to Your Story")
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.title2)
                            .foregroundColor(.secondary)
                            .padding([.leading], 10)
                    }
                    .padding([.leading, .trailing], 15)
                    let isPostUserSelected = selectedUsers.contains(where: {_u in
                        _u == post.username
                    })
                    HStack{
                        ProfilePhoto(user: post.user, showStoryBorder: false)
                            .frame(width: 50, height: 50)
                            .padding([.trailing], 10)
                        Text("Reply to \(post.user.fullName)")
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: isPostUserSelected  ? "checkmark.circle.fill":"circle")
                            .font(.title2)
                            .foregroundColor(isPostUserSelected ? .blue : .secondary)
                            .padding([.leading], 10)
                    }
                    .padding([.leading, .trailing], 15)
                    .onTapGesture {
                        if(isPostUserSelected){
                            selectedUsers.removeAll(where: {_u in
                                _u == post.username
                            })
                        }
                        else{
                            selectedUsers.append(post.username)
                        }
                    }
                    ForEach(messages, id: \.self){ message in
                        var isSelected = selectedUsers.contains(where: {_u in
                            _u == message.user?.username ?? message.group_info?.groupName ?? ""
                        })
                        HStack{
                            MessageItemProfilePhoto(message: message, width: 50, height: 50)
                                .padding([.trailing], 10)
                            VStack(alignment: .leading, spacing: 0){
                                Text("\(message.user?.fullName ?? message.group_info?.groupName ?? "")")
                                    .fontWeight(.bold)
                                    .frame(height: 20)
                                Text("\(message.user?.username ?? message.group_info?.allUserNames ?? "")")
                                    .frame(height: 20)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: isSelected  ? "checkmark.circle.fill": "circle")
                                .font(.title2)
                                .foregroundColor(isSelected ? .blue : .secondary)
                                .padding([.leading], 10)
                        }
                        .padding([.leading, .trailing], 15)
                        .onTapGesture {
                            if(isSelected){
                                selectedUsers.removeAll(where: {_u in
                                    _u == message.user?.username ?? message.group_info?.groupName ?? ""
                                })
                            }
                            else {
                                selectedUsers.append(message.user?.username ?? message.group_info?.groupName ?? "")
                            }
                        }
                    }
                }
                .padding([.top], 10)
            }
            Divider()
            VStack(alignment: .leading){
                if(selectedUsers.count > 0){
                    HStack {
                        Text("Write a message...")
                            .foregroundColor(.secondary)
                            .padding(10)
                        Spacer()
                    }
                    .padding([.top, .leading], 10)
                    Divider()
                    Button(action: {
                        isShareSheetOpen.toggle()
                    }){
                        HStack{
                            Spacer()
                            Text("Send")
                                .padding(15)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .background(.blue)
                        .cornerRadius(8)
                        .padding([.leading, .trailing],15)
                        .padding([.top], 5)
                    }
                }
                else {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 20) {
                            ForEach(0...shareIcons.count - 1, id: \.self){ i in
                                VStack {
                                    Section{
                                        if(shareIcons[i] == "whatsapp"){
                                            Image("whatsapp")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                        }
                                        else{
                                            Image(systemName: shareIcons[i])
                                                .font(.title2)
                                                .fontWeight(.semibold)
                                        }
                                    }
                                    .padding(15)
                                    .background(.secondary.opacity(0.5))
                                    .cornerRadius(.infinity)
                                    Text(shareName[i])
                                }
                            }
                        }
                        .padding([.leading, .trailing], 20)
                        .padding([.top], 10)
                    }
                }
            }
            .animation(.easeInOut(duration: 0.2), value: selectedUsers.count)
        }
        .presentationDetents([.fraction(0.7), .large])
    }
}
