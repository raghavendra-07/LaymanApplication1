//
//  RootView.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import SwiftUI

struct RootView: View {
    
    @State private var hasSeenWelcome = false
    @StateObject private var vm = AuthViewModel()
    
    var body: some View {
        
        if !hasSeenWelcome {
            WelcomeView(hasSeenWelcome: $hasSeenWelcome)
            
        } else if vm.isLoggedIn {
            ContentView(vm: vm)
            
        } else {
            AuthView(vm: vm)
        }
    }
}
