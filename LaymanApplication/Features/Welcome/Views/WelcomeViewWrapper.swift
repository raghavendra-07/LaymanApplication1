//
//  WelcomeViewWrapper.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import SwiftUI


struct WelcomeViewWrapper: View {
    @Binding var hasSeenWelcome: Bool
    
    var body: some View {
        WelcomeView(hasSeenWelcome: $hasSeenWelcome)
            .onDisappear {
                hasSeenWelcome = true
            }
    }
}
