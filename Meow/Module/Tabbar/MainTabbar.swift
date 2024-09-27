//
//  MainTabbar.swift
//  Meow
//
//  Created by phrygian on 2024/9/25.
//

import SwiftUI

struct MainTabbar: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Image(systemName: "flame") }
                .tag(0)
            
            Text("Search View")
                .tabItem { Image(systemName: "magnifyingglass") }
                .tag(1)
            
            Text("Inbox View")
                .tabItem { Image(systemName:"message.fill") }
                .tag(2)
            
            Text("Inbox View")
                .tabItem { Image(systemName:"shield.fill") }
                .tag(3)
            
            Text("Profile View")
                .tabItem { Image(systemName: "person.fill") }
                .tag(4)
        }
        .tint(.pink)
    }
}

#Preview {
    MainTabbar()
}
