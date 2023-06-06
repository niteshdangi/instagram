//
//  App.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 11/05/23.
//

import SwiftUI

struct AppScreen: View {
    @State private var selection = "home"
    @State private var mainSelection = "reel"
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                CameraScreen(goHome: {goTo()})
                    .tag("camera")
                VStack {
                    TabView(selection: $mainSelection){
                        HomeScreen(goTo: goTo)
                            .tag("home")
                            .tabItem {
                                Image(systemName: "house")
                            }
                        SearchScreen()
                            .tag("search")
                            .tabItem {
                                Image(systemName: "magnifyingglass")
                            }
                        Text("")
                            .tag("post")
                            .tabItem {
                                Image(systemName: "plus.square")
                            }
                            .onAppear {
                                mainSelection = "home"
                                selection = "camera"
                            }
                        ReelScreen()
                            .tag("reels")
                            .tabItem {
                                Image(systemName: "video")
                            }
                        
                        Text("Profile")
                            .tag("profile")
                            .tabItem {
                                Image(systemName: "person")
                            }
                    }
                    .tabViewStyle(DefaultTabViewStyle())
                    .tint(.black)
                    .onAppear(perform: {
                        let tabBar = UITabBar.appearance()
                        tabBar.backgroundColor = .white
                        tabBar.isTranslucent = true
                    })
                    .padding([.top, .bottom], 0.1)
                    
                }
                .tag("home")
                .background(.white)

                MessagesScreen(goHome: {goTo()})
                    .tag("messages")
                    .background(.white)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .edgesIgnoringSafeArea([.bottom, .top])
            .background(.black)
            .navigationTitle("")
        }
        
        
    }
    
    func goTo(tab: String = "home"){
        withAnimation {
            selection = tab
        }
    }
}

struct AppScreen_Previews: PreviewProvider {
    static var previews: some View {
        AppScreen()
    }
}
