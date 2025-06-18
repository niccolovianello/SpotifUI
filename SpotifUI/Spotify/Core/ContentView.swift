//
//  ContentView.swift
//  SpotifUI
//
//  Created by Niccolò Vianello on 13/06/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            
            Tab("Home", systemImage: "house.fill") {
                ZStack {
                    Color.spotifyBlack
                        .ignoresSafeArea()
                    SpotifyHomeView()
                }
            }
            
            Tab("Search", systemImage: "magnifyingglass") {
                EmptyView()
            }
            
            Tab("Your library", systemImage: "books.vertical.fill") {
                EmptyView()
            }
            
            Tab("Create", systemImage: "plus") {
                EmptyView()
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    ContentView()
}
