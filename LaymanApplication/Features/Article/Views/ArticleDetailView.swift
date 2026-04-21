//
//  ArticleDetailView.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import SwiftUI
import SafariServices

struct ArticleDetailView: View {
    
    let article: NewsArticle
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var savedManager = SavedArticlesManager.shared
    
    @State private var selectedIndex = 0
    @State private var showWeb = false
    @State private var showChat = false   // ✅ NEW
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // MARK: - TOP BAR
            HStack {
                
                // Back Button
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                // Open Link
                Button {
                    showWeb = true
                } label: {
                    Image(systemName: "link")
                        .foregroundColor(.orange)
                }
                
                // Bookmark
                Button {
                    withAnimation(.spring()) {
                        savedManager.toggleSave(article: article)
                    }
                } label: {
                    Image(systemName: savedManager.isSaved(article) ? "bookmark.fill" : "bookmark")
                        .foregroundColor(.orange)
                }
                
                // Share
                Button {
                    shareArticle()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // MARK: - CONTENT
            ScrollView {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    // HEADLINE
                    Text(article.title)
                        .font(.title2.bold())
                        .lineLimit(2)
                    
                    // IMAGE
                    AsyncImage(url: URL(string: article.image_url ?? "")) { image in
                        image.resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(16)
                    
                    // CONTENT CARDS
                    TabView(selection: $selectedIndex) {
                        ForEach(0..<3) { index in
                            ContentCard(text: sampleContent[index])
                                .tag(index)
                                .padding(.horizontal, 4)
                        }
                    }
                    .frame(height: 160)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                }
                .padding()
            }
            
            // MARK: - ASK LAYMAN BUTTON ✅ UPDATED
            Button {
                showChat = true
            } label: {
                Text("Ask Layman")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        
        // MARK: - WEB VIEW
        .sheet(isPresented: $showWeb) {
            SafariView(url: URL(string: article.link ?? "https://google.com")!)
        }
        
        // MARK: - CHAT BOTTOM SHEET ✅ MAIN FIX
        .sheet(isPresented: $showChat) {
            ChatView(article: article)
                .presentationDetents([.medium, .large])   // 🔥 HALF + FULL
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(24)
        }
    }
}

// MARK: - SHARE FUNCTION
extension ArticleDetailView {
    func shareArticle() {
        guard let url = URL(string: article.link ?? "https://google.com") else { return }
        
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let root = scene.windows.first?.rootViewController {
            root.present(activityVC, animated: true)
        }
    }
}

