//
//  NewsService.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//


import Foundation

class NewsService {
    
    func fetchArticles() async throws -> [NewsArticle] {
        
        let urlString = "https://newsdata.io/api/1/news?apikey=\(Config.newsAPIKey)&category=technology,business"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(NewsResponse.self, from: data)
        
        return decoded.results
    }
}

