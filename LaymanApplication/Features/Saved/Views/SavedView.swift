//
//  SavedView.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import SwiftUI

struct SavedView: View {
    
//    @StateObject private var savedManager = SavedArticlesManager.shared
    @ObservedObject var savedManager = SavedArticlesManager.shared
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                if savedManager.savedArticles.isEmpty {
                    Text("No saved articles yet")
                        .padding()
                } else {
                    VStack(spacing: 12) {
                        
                        ForEach(savedManager.savedArticles) { article in
                            NavigationLink {
                                ArticleDetailView(article: article)
                            } label: {
                                HStack(spacing: 12) {
                                    
                                    AsyncImage(url: URL(string: article.image_url ?? "")) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 70, height: 70)
                                    .cornerRadius(12)
                                    
                                    Text(article.title)
                                        .font(.subheadline)
                                        .lineLimit(2)
                                    
                                    Spacer()
                                }
                                .padding(10)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Saved")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
    }
}

//#Preview {
//    SavedView()
//}

