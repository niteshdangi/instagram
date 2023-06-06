//
//  PostOptionSheet.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 14/05/23.
//

import SwiftUI

struct PostOptionSheet: View {
    @Binding var isOpen: Bool
    var onSave: () -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "bookmark")
                            .resizable()
                            .frame(width: 20, height: 22)
                        Text("Save")
                    }
                    Spacer()
                }
                .padding([.top, .bottom], 20)
                .background(.secondary.opacity(0.2))
                .cornerRadius(10)
                .onTapGesture {
                    isOpen.toggle()
                    onSave()
                }
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "arrow.down.backward.square")
                            .resizable()
                            .frame(width: 20, height: 22)
                        Text("Remix")
                    }
                    Spacer()
                }
                .padding([.top, .bottom], 20)
                .background(.secondary.opacity(0.2))
                .cornerRadius(10)
            }
            .padding([.leading, .trailing], 15)
            VStack(spacing: 15) {
                HStack {
                    Image(systemName: "star")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Add to Favourites")
                        .font(.title3)
                    Spacer()
                }
                .padding([.leading, .trailing], 15)
                Divider()
                HStack {
                    Image(systemName: "person")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Unfollow")
                        .font(.title3)
                    Spacer()
                }
                .padding([.leading, .trailing], 15)
            }
            .padding([.top, .bottom], 15)
            .background(.secondary.opacity(0.2))
            .cornerRadius(10)
            .padding([.leading, .trailing], 15)
            
            VStack(spacing: 15) {
                HStack {
                    Image(systemName: "person.circle")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("About This Account")
                        .font(.title3)
                    Spacer()
                }
                .padding([.leading, .trailing], 15)
                Divider()
                HStack {
                    Image(systemName: "qrcode")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("QR Code")
                        .font(.title3)
                    Spacer()
                }
                .padding([.leading, .trailing], 15)
                Divider()
                HStack {
                    Image(systemName: "info.circle")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Why you're seeing this post")
                        .font(.title3)
                    Spacer()
                }
                .padding([.leading, .trailing], 15)
                Divider()
                HStack {
                    Image(systemName: "eye.slash")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Hide")
                        .font(.title3)
                    Spacer()
                }
                .padding([.leading, .trailing], 15)
                Divider()
                HStack {
                    Image(systemName: "exclamationmark.arrow.circlepath")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    Text("Report")
                        .font(.title3)
                        .foregroundColor(.red)
                    Spacer()
                }
                .padding([.leading, .trailing], 15)
            }
            .padding([.top, .bottom], 15)
            .background(.secondary.opacity(0.2))
            .cornerRadius(10)
            .padding([.leading, .trailing], 15)
        }
        .onTapGesture {
            isOpen.toggle()
        }
        .padding([.top], 10)
        .presentationDetents([.fraction(0.7), .fraction(0.701)])
    }
}
