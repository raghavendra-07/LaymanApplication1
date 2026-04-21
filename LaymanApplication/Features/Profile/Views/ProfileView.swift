//
//  ProfileView.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var vm: AuthViewModel
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 20) {
                
                // MARK: - PROFILE HEADER
                VStack(spacing: 10) {
                    
                    Circle()
                        .fill(Color.orange.opacity(0.2))
                        .frame(width: 80, height: 80)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.orange)
                        )
                    
                    Text(vm.userName.isEmpty ? "User" : vm.userName)
                        .font(.title3.bold())
                    
                    Text(vm.userEmail)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top)
                
                // MARK: - SETTINGS
                VStack(spacing: 16) {
                    
                    ProfileRow(icon: "gear", title: "Settings")
                    ProfileRow(icon: "bell", title: "Notifications")
                    ProfileRow(icon: "questionmark.circle", title: "Help & Support")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .padding(.horizontal)
                
                Spacer()
                
                // MARK: - LOGOUT BUTTON
                Button {
                    Task {
                        await vm.signOut()
                    }
                } label: {
                    Text("Sign Out")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .padding()
            }
            .navigationTitle("Profile")
        }
    }
}


//#Preview {
//    ProfileView(vm: vm)
//}

