//
//  ArticleRowView.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import SwiftUI

struct ArticleRowAPI: View {
    let article: NewsArticle
    
    var body: some View {
//        HStack(spacing: 12) {
//            
//            AsyncImage(url: URL(string: article.image_url ?? "")) { image in
//                image.resizable()
//            } placeholder: {
//                Color.gray
//            }
//            .frame(width: 70, height: 70)
//            .cornerRadius(12)
//            
//            Text(article.title)
//                .font(.subheadline)
//                .lineLimit(2)
//            
//            Spacer()
//        }
//        .padding(10)
//        .background(Color(.systemGray6))
//        .cornerRadius(12)
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

