//
//  HomeViewModel.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import Foundation
import Combine   //  THIS WAS MISSING

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var articles: [NewsArticle] = []
    @Published var isLoading = false
    
    private let service = NewsService()
    
    func loadArticles() {
        Task {
            do {
                isLoading = true
                articles = try await service.fetchArticles()
                isLoading = false
            } catch {
                print("Error fetching:", error)
                isLoading = false
            }
        }
    }
}

