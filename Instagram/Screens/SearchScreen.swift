//
//  SearchScreen.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 14/05/23.
//

import SwiftUI

var gridFirst = [
    GridItem(.fixed(260), spacing: 2, alignment: .leading),
    GridItem(.fixed(130), spacing: 1, alignment: .leading)
]
var grid2x2 = [
    GridItem(.fixed(130), spacing: 1, alignment: .leading),
    GridItem(.fixed(130), spacing: 1, alignment: .leading)
]

struct SearchScreen: View {
    @State var searchText: String = ""
    @State var searchFocused: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black.opacity(0.6))
                    TextField("Search", text: $searchText, onEditingChanged: { editingChanged in
                        withAnimation {
                            searchFocused = editingChanged
                        }
                    })
                }
                .padding(8)
                .background(.gray.opacity(0.2))
                .cornerRadius(8)
                .padding([.leading], 15)
                .padding([.trailing], searchFocused ? 10 : 15)
                .animation(.easeInOut, value: searchFocused)
                .zIndex(2)
                if(searchFocused){
                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                    }) {
                        Text("Cancel")
                    }
                    .transition(.asymmetric(insertion: .slide, removal: .slide))
                    .padding([.trailing], 15)
                }
            }
            .padding([.bottom], 5)
            ScrollView {
                VStack(spacing: 1) {
                    ForEach(explorePosts, id: \.self){ post in
                        LazyVGrid(columns: post.isReverse ?? false ? gridFirst.reversed() : gridFirst, spacing: 0){
                            if(post.isReverse ?? false && post.vertical != nil){
                                AsyncImage(
                                    url: URL(string: post.vertical!)
                                ) { image in
                                    image.resizable()
                                } placeholder: {
                                    HStack {
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(.gray)
                                }
                                .frame(width:130, height:  260)
                            }
                            if(post.square != nil){
                                VStack(spacing: 1) {
                                    ForEach(post.grid, id: \.self) { gridPost in
                                        AsyncImage(
                                            url: URL(string: gridPost)
                                        ) { image in
                                            image.resizable()
                                        } placeholder: {
                                            HStack {
                                                Spacer()
                                            }
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .background(.gray)
                                        }
                                        .frame(width:130, height:  130)
                                    }
                                }
                                AsyncImage(
                                    url: URL(string: post.square!)
                                ) { image in
                                    image.resizable()
                                } placeholder: {
                                    HStack {
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(.gray)
                                }
                                .frame(width:260, height:  260)
                            }
                            else {
                                LazyVGrid(columns: grid2x2, spacing: 1) {
                                    ForEach(post.grid, id: \.self) { gridPost in
                                        AsyncImage(
                                            url: URL(string: gridPost)
                                        ) { image in
                                            image.resizable()
                                        } placeholder: {
                                            HStack {
                                                Spacer()
                                            }
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .background(.gray)
                                        }
                                        .frame(width:130, height:  130)
                                    }
                                }
                            }
                            if(!(post.isReverse ?? false) && post.vertical != nil){
                                AsyncImage(
                                    url: URL(string: post.vertical!)
                                ) { image in
                                    image.resizable()
                                } placeholder: {
                                    HStack {
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(.gray)
                                }
                                .frame(width:130, height:  260)
                            }
                        }
                    }
                }
            }
            .opacity(searchFocused ? 0 : 1)
            
            Divider()
                .padding([.bottom], 55)
        }
    }
}
