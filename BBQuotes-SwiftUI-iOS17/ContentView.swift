//
//  ContentView.swift
//  BBQuotes-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 03/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Breaking Bad View")
                .toolbarBackground(.visible, for: .tabBar) // to show tabview bar when clicked on this tab
                .tabItem {
                    //tabItem - to add tabs on tabView
                    //Label - what to show for current tab
                    Label("Breaking Bad",
                          systemImage: "tortoise")
                }
            
            Text("Better Call Saul View")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label("Better Call Saul",
                          systemImage: "briefcase")
                }
        }
        .preferredColorScheme(.dark) //this makes app theme dark, inspite of what theme is set on user's iphone 
    }
}

#Preview {
    ContentView()
}
