//
//  ChatView.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//


import SwiftUI

struct ChatView: View {
    
    let article: NewsArticle
    
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "Hi, I'm Layman! What can I answer for you?", isUser: false)
    ]
    
    @State private var inputText = ""
    @State private var isLoading = false
    
    let suggestions = [
        "What is this article about?",
        "Why is this important?",
        "Explain in simple terms"
    ]
    
    var body: some View {
        
        VStack {
            
            // MARK: - HEADER
            HStack {
                Button {
                    // dismiss handled by navigation
                } label: {
                    Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                Text("Ask Layman")
                    .font(.headline)
                
                Spacer()
                
                Spacer().frame(width: 24)
            }
            .padding()
            
            // MARK: - CHAT AREA
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // MARK: - BOT INTRO
                    botBubble(text: messages.first?.text ?? "")
                    
                    // MARK: - SUGGESTIONS
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Question Suggestions:")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        ForEach(suggestions, id: \.self) { suggestion in
                            Button {
                                sendMessage(suggestion)
                            } label: {
                                Text(suggestion)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 10)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    
                    // MARK: - MESSAGES
                    ForEach(messages.dropFirst()) { message in
                        if message.isUser {
                            userBubble(text: message.text)
                        } else {
                            botBubble(text: message.text)
                        }
                    }
                }
                .padding()
            }
            
            // MARK: - INPUT BAR
            HStack {
                
                TextField("Type your question...", text: $inputText)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                Button {
                    sendMessage(inputText)
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.orange)
                }
            }
            .padding()
        }
    }
    
    // MARK: - USER BUBBLE
    func userBubble(text: String) -> some View {
        HStack {
            Spacer()
            Text(text)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(16)
        }
    }
    
    // MARK: - BOT BUBBLE
    func botBubble(text: String) -> some View {
        HStack(alignment: .top) {
            
            Text("✨")
            
            Text(text)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(16)
            
            Spacer()
        }
    }
    
    // MARK: - SEND MESSAGE
    func sendMessage(_ text: String) {
        guard !text.isEmpty else { return }
        
        messages.append(ChatMessage(text: text, isUser: true))
        inputText = ""
        
        Task {
            isLoading = true
            
            do {
                let response = try await GeminiService.shared.askAI(
                    question: text,
                    context: article.description ?? article.title
                )
                
                messages.append(ChatMessage(text: response, isUser: false))
                
            } catch {
                messages.append(ChatMessage(text: "Something went wrong", isUser: false))
            }
            
            isLoading = false
        }
    }
}
