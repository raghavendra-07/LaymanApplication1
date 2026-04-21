//
//  ContentView.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm: AuthViewModel
    
    var body: some View {
        
        TabView {
            
            // MARK: - Home
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            // MARK: - Saved
            SavedView()
                .tabItem {
                    Image(systemName: "bookmark.fill")
                    Text("Saved")
                }
            
            // MARK: - Profile
            ProfileView(vm: vm)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .tint(.orange)
    }
}
