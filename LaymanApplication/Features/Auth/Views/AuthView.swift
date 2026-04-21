//
//  AuthView.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import SwiftUI

struct AuthView: View {
    
//    @StateObject private var vm = AuthViewModel()
    @ObservedObject var vm: AuthViewModel
    
    @State private var isSignUp = false
    @State private var email = ""
    @State private var password = ""
    @State private var fullName = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    
    var body: some View {
        ZStack {
            
            // MARK: - Warm Gradient Background (MATCHES YOUR APP)
            LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.85, blue: 0.75),
                    Color(red: 1.0, green: 0.6, blue: 0.4)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                // MARK: - Logo
                Text("Layman")
                    .font(.system(size: 32, weight: .bold))
                
                Text("Business, tech & startups made simple")
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.top, 4)
                
                Spacer()
                
                // MARK: - Card Container
                VStack(spacing: 16) {
                    
                    Text("Get started")
                        .font(.headline)
                    
                    // MARK: - Toggle
                    HStack {
                        Button("Sign In") {
                            isSignUp = false
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(!isSignUp ? Color.orange : Color.clear)
                        .foregroundColor(!isSignUp ? .white : .black)
                        .cornerRadius(10)
                        
                        Button("Sign Up") {
                            isSignUp = true
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isSignUp ? Color.orange : Color.clear)
                        .foregroundColor(isSignUp ? .white : .black)
                        .cornerRadius(10)
                    }
                    .background(Color.orange.opacity(0.2))
                    .cornerRadius(12)
                    
                    // MARK: - Inputs
                    
                    if isSignUp {
                        TextField("Full Name", text: $fullName)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    HStack {
                        if showPassword {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        
                        Button {
                            showPassword.toggle()
                        } label: {
                            Image(systemName: "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    if isSignUp {
                        SecureField("Confirm Password", text: $confirmPassword)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    
                    // MARK: - Error Message
                    if let error = vm.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    // MARK: - Button
                    Button {
                        Task {
                            if isSignUp {
                                guard password == confirmPassword else {
                                    vm.errorMessage = "Passwords do not match"
                                    return
                                }
                                await vm.signUp(email: email, password: password, fullName: fullName)
                            } else {
                                await vm.signIn(email: email, password: password)
                            }
                        }
                    } label: {
                        Text(isSignUp ? "Create Account" : "Sign In")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    if vm.isLoading {
                        ProgressView()
                    }
                    
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(20)
                .padding()
                
            }
        }
//        .fullScreenCover(isPresented: $vm.isLoggedIn) {
//            ContentView() // your main app
//        }
    }
}

