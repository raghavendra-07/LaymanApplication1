//
//  HomeView.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                if vm.isLoading {
                    ProgressView()
                        .padding()
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: - Featured Carousel
                    TabView {
                        ForEach(vm.articles.prefix(5)) { article in
                            FeaturedCardAPI(article: article)
                            ArticleRowAPI(article: article)
                        }
                    }
                    .frame(height: 220)
                    .tabViewStyle(PageTabViewStyle())
                    
                    // MARK: - Picks
                    HStack {
                        Text("Today's Picks")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("View All")
                            .foregroundColor(.orange)
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        ForEach(vm.articles) { article in
                            ArticleRowAPI(article: article)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Layman")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "magnifyingglass")
                }
            }
            .onAppear {
                vm.loadArticles()
            }
        }
    }
}

#Preview {
    HomeView()
}
