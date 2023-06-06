//
//  ReelScreen.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 14/05/23.
//

import SwiftUI

struct ReelScreen: View {
    @State var selection = "0"
    var body: some View {
        GeometryReader { proxy in
            TabView(selection: $selection) {
                ZStack{
                    
                }
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .rotationEffect(.degrees(-90))
                    .rotation3DEffect(Angle(degrees: 90), axis: (x: 1, y: 0, z: 0))
            }
            .frame(width: proxy.size.height, height: proxy.size.width)
            .rotation3DEffect(Angle(degrees: 90), axis: (x: 1, y: 0, z: 0))
            .rotationEffect(.degrees(90), anchor: .topLeading)
            .offset(x: proxy.size.width)
        }.tabViewStyle(PageTabViewStyle())
    }
}
