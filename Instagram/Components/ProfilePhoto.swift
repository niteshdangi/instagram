//
//  ProfilePhoto.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 10/05/23.
//

import SwiftUI

struct ProfilePhoto: View {
    var user: User
    var showPlus: Bool?
    var showActiveStatus: Bool?
    var showStoryBorder: Bool = true
    var action: (() -> Void)?
    
    private func showStoryIndicator() -> Bool { return !((showPlus ?? false) || (showActiveStatus ?? false)) && (user.storyAvailable ?? false) && showStoryBorder}
    
    var body: some View {
        Button(action: action ?? {}) {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(
                    url: URL(string: user.image)
                ) { image in
                    image.resizable()
                } placeholder: {
                    HStack {
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.gray)
                    .cornerRadius(.infinity)
                }
                .cornerRadius(.infinity)
                .padding(showStoryIndicator() ? 4 : 0)
                .overlay(
                    HStack{
                        if showStoryIndicator() {
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(
                                            colors:
                                                user.storyViewed ?? false ? [Color.gray.opacity(0.5)]
                                            : [Color.red, Color.blue, Color.yellow]
                                        ),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2)
                            
                                .padding([.top, .bottom], 1)
                        }
                    }
                )
                if showPlus ?? false {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .zIndex(2)
                            .foregroundColor(.blue)
                            .alignmentGuide(.top, computeValue: { dimension in
                                dimension[.top]
                            })
                            .alignmentGuide(.leading, computeValue: { dimension in
                                dimension[.leading]
                            })
                            .background(.white)
                            .cornerRadius(.infinity)
                            .padding(3)
                    }
                    .background(.white)
                    .cornerRadius(.infinity)
                }
                if showActiveStatus ?? false {
                    HStack {
                        Spacer()
                            .frame(width: 13, height: 13)
                            .background(.green)
                            .cornerRadius(.infinity)
                            .padding(3)
                    }
                        .background(.white)
                        .cornerRadius(.infinity)
                        .padding([.trailing, .bottom],3)
                }
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut.speed(1.5), value: configuration.isPressed)
    }
}
