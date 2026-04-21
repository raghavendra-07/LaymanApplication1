//
//  WelcomeView.swift
//  LaymanApplication
//
//  Created by V Raghavendra Chary on 21/04/26.
//

import SwiftUI

struct WelcomeView: View {
    
    @Binding var hasSeenWelcome: Bool
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ZStack {
            
            // MARK: - Background Gradient (soft like design)
            LinearGradient(
                colors: [
                    Color(hex: "#F5E2D4"),
                    Color(hex: "#F2A172")
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40){
                
                Spacer()
                
                // MARK: - Title
                Text("Layman")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                // MARK: - Subtitle
                VStack(spacing: 8) {
                    
                    Text("Business, tech & startups")
                            .font(.system(size: 26, weight: .semibold)) // ⬅️ bigger + single line
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .lineLimit(1) // ⬅️ force single line
                        
                        Text("made simple")
                            .font(.system(size: 26, weight: .bold)) // ⬅️ bigger
                            .foregroundColor(Color(hex: "#E8742B"))
                }
                
                Spacer()
                
                // MARK: - Swipe Button
                ZStack {
                    
                    // Background capsule (light orange)
                    Capsule()
                        .fill(Color(hex: "#F5B38D"))
                        .frame(height: 65)
                    
                    Text("Swipe to get started")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                    
                    HStack {
                        
                        // MARK: - Slider Circle
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 55, height: 55)
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(hex: "#E8742B"))
                                .font(.system(size: 18, weight: .bold))
                        }
                        .offset(x: offset)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if value.translation.width > 0 &&
                                        value.translation.width < 260 {
                                        offset = value.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    if offset > 220 {
                                        hasSeenWelcome = true
                                    } else {
                                        withAnimation {
                                            offset = 0
                                        }
                                    }
                                }
                        )
                        
                        Spacer()
                    }
                    .padding(5)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }
}

// MARK: - HEX COLOR SUPPORT
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let r, g, b: UInt64
        (r, g, b) = ((int >> 16) & 0xFF,
                     (int >> 8) & 0xFF,
                     int & 0xFF)
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }
}

#Preview {
    WelcomeView(hasSeenWelcome: .constant(false))
}
