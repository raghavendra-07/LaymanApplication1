//
//  ProfileRow.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import SwiftUI

struct ProfileRow: View {
    
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: 12) {
            
            Image(systemName: icon)
                .foregroundColor(.orange)
            
            Text(title)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}
