//
//  NewsArticle.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import Foundation

struct NewsResponse: Codable {
    let results: [NewsArticle]
}

struct NewsArticle: Codable, Identifiable {
    let id = UUID().uuidString
    let title: String
    let image_url: String?
    let link: String?
    let description: String?
}
