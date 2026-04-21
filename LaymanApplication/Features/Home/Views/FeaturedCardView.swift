//
//  FeaturedCardView.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import SwiftUI

struct FeaturedCardAPI: View {
    let article: NewsArticle
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            AsyncImage(url: URL(string: article.image_url ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .scaledToFill()
            .frame(height: 220)
            .clipped()
            .cornerRadius(20)
            
            LinearGradient(
                colors: [.clear, .black.opacity(0.7)],
                startPoint: .center,
                endPoint: .bottom
            )
            .cornerRadius(20)
            
            Text(article.title)
                .foregroundColor(.white)
                .font(.headline)
                .padding()
        }
        .padding(.horizontal)
    }
}

