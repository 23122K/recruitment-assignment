//
//  Recruitment_assignmentApp.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import SwiftUI

@main
struct Recruitment_assignmentApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                WelcomeView()
                    .tabItem {
                        Image(systemName: "person.2.fill")
                        Text("Characters")
                    }
                
                FavoriteView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Favorite")
                    }
                
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
            }
        }
    }
}
