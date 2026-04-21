//
//  AuthViewModel.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import Foundation
import Supabase
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    @Published var userEmail: String = ""
    @Published var userName: String = ""
    
    private let client = SupabaseManager.shared.client
    
    // ❌ NO session check (you don't want auto login)
    init() {
        isLoggedIn = false
    }
    
    func signIn(email: String, password: String) async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill all fields"
            return
        }
        
        do {
            isLoading = true
            errorMessage = nil
            
            try await client.auth.signIn(
                email: email,
                password: password
            )
            
            isLoggedIn = true
            
            if let user = try? await client.auth.session.user {
                userEmail = user.email ?? ""
                userName = user.userMetadata["full_name"] as? String
                    ?? user.email?.components(separatedBy: "@").first
                    ?? "User"
            }
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func signUp(email: String, password: String, fullName: String) async {
        
        guard !email.isEmpty, !password.isEmpty, !fullName.isEmpty else {
            errorMessage = "Please fill all fields"
            return
        }
        
        do {
            isLoading = true
            errorMessage = nil
            
            try await client.auth.signUp(
                email: email,
                password: password,
                data: [
                    "full_name": .string(fullName) 
                ]
            )
            
            isLoggedIn = true
            
            // Set user data immediately
            userEmail = email
            userName = fullName
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func signOut() async {
        try? await client.auth.signOut()
        isLoggedIn = false
    }
}

