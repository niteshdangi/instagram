//
//  CameraScreen.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 13/05/23.
//

import Foundation
import SwiftUI

struct CameraScreen: View {
    var goHome: () -> Void
    var body: some View {
        
        GeometryReader { mainView in
            VStack {
                ZStack {
                    VStack {
                        HStack{
                            Button(action: goHome){
                                Image(systemName: "xmark")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .shadow(radius: 3)
                            }
                            Spacer()
                            Image(systemName: "flashlight.off.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                                .shadow(radius: 3)
                            Spacer()
                            Image(systemName: "gear")
                                .font(.title2)
                                .foregroundColor(.white)
                                .shadow(radius: 3)
                        }
                        .padding(25)
                        Spacer()
                        HStack{
                            VStack(spacing: 25) {
                                Text("Aa")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .shadow(radius: 3)
                                
                                Image(systemName: "infinity")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .shadow(radius: 3)
                                
                                Image(systemName: "rectangle.3.offgrid")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .shadow(radius: 3)
                                
                                Image(systemName: "chevron.down")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .shadow(radius: 3)
                            }
                            Spacer()
                        }
                        .padding(25)
                        Spacer()
                        ZStack {
                            
                            HStack {
                                ScrollViewReader { scrollViewProxy in
                                    ScrollView(.horizontal, showsIndicators: false){
                                        HStack {
                                            ForEach(users.indices, id: \.self){index in
                                                let user = users[index]
                                                GeometryReader { item in
                                                    ProfilePhoto(user: user)
                                                        .frame(width: 80, height: 80)
                                                        .scaleEffect(scaleValue(mainFrame: mainView.frame(in: .global).minX, minX: item.frame(in: .global).minX, mainFrameEnd: mainView.frame(in: .global).maxX, maxX: item.frame(in: .global).maxX))
                                                        .id(index)
                                                    
                                                }
                                                .frame(width: 80, height: 80)
                                            }
                                        }
                                        .padding([.leading, .trailing], (mainView.frame(in: .global).maxX / 2) - 40)
                                    }
                                }
                            }
                            .padding([.top, .bottom])
                        }
                    }
                }
                .background(.white)
                .cornerRadius(25)
                .padding([.top, .bottom])
                HStack {
                    AsyncImage(
                        url: URL(string: "https://source.unsplash.com/200x200/?user,profile,nitesh")
                    ) { image in
                        image.resizable()
                    } placeholder: {
                        HStack {
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.gray)
                        .cornerRadius(8)
                        .frame(width: 40, height: 40)
                        .padding(2)
                        .background(.white)
                        .cornerRadius(8)
                    }
                    .cornerRadius(8)
                    .frame(width: 40, height: 40)
                    .padding(2)
                    .background(.white)
                    .cornerRadius(8)
                    Spacer()
                    Text("POST")
                        .foregroundColor(.white.opacity(0.7))
                    Text("STORY")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Text("REEL")
                        .foregroundColor(.white.opacity(0.7))
                    Text("LIVE")
                        .foregroundColor(.white.opacity(0.7))
                    Image(systemName: "arrow.clockwise")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding([.top, .bottom], 8)
                        .padding([.leading, .trailing], 10)
                        .background(.white.opacity(0.6))
                        .cornerRadius(.infinity)
                        .padding([.leading])
                }
                .padding([.leading, .trailing, .bottom])
            }
            .background(.black)
        }
        .background(.black)
    }
    
    
    private func scaleValue(mainFrame: CGFloat, minX: CGFloat, mainFrameEnd: CGFloat, maxX: CGFloat) ->CGFloat {
        var scale = minX / (mainFrameEnd / 2 - 40)
        if(scale > 1){
            scale = 2 - (minX / (mainFrameEnd / 2 - 20))
            if(scale > 1){
                return 1
            }
            if(scale < 0) {
                return 0
            }
            else {
                return scale
            }
        }
        if(scale < 0) {
            return 0
        }
        return scale
    }
    
}
