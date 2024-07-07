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
            FetchView(show: Constants.bbName)
                .toolbarBackground(.visible, for: .tabBar) // to show tabview bar when clicked on this tab
                .tabItem {
                    //tabItem - to add tabs on tabView
                    //Label - what to show for current tab
                    Label(Constants.bbName,
                          systemImage: "tortoise")
                }
            
            FetchView(show: Constants.bcsName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.bcsName,
                          systemImage: "briefcase")
                }
            
            FetchView(show: Constants.ecName)
                .toolbarBackground(.visible, for: .tabBar) // to show tabview bar when clicked on this tab
                .tabItem {
                    //tabItem - to add tabs on tabView
                    //Label - what to show for current tab
                    Label(Constants.ecName,
                          systemImage: "car")
                }
        }
        .preferredColorScheme(.dark) //this makes app theme dark, inspite of what theme is set on user's iphone 
    }
}

#Preview {
    ContentView()
}
