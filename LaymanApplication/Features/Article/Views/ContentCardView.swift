//
//  ContentCardView.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import Foundation
import SwiftUI

struct ContentCard: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.subheadline)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemGray6))
            .cornerRadius(16)
    }
}
