//
//  SavedArticlesManager.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import Foundation
import Combine

class SavedArticlesManager: ObservableObject {
    
    static let shared = SavedArticlesManager()
    
    @Published var savedArticles: [NewsArticle] = []
    
    func toggleSave(article: NewsArticle) {
        if isSaved(article) {
            savedArticles.removeAll { $0.id == article.id }
        } else {
            savedArticles.append(article)
        }
    }
    
    func isSaved(_ article: NewsArticle) -> Bool {
        savedArticles.contains { $0.id == article.id }
    }
}

