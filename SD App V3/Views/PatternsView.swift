//
//  PatternsView.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/12/24.
//

import SwiftUI

struct PatternsView: View {
    var body: some View {
        ZStack {
            
            Color(.systemGray5).ignoresSafeArea()
            
            VStack() {
                
                // Title
                Text("Patterns")
                    .font(Font.custom("TitanOne", size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        Text("Favorites")
                            .font(Font.custom("TitanOne", size: 23))
                            .padding(.horizontal, 30)
                        
                        FavoritesCarousel(width: 175, height: 175)
                            .padding(.horizontal)
                        
                        Text("All Patterns")
                            .font(Font.custom("TitanOne", size: 23))
                            .padding(.horizontal, 30)
                        
                        // List of Patterns centered
                        ForEach(laserPatterns) { pattern in
                            PatternCard(iconName: pattern.iconName, name: pattern.name, description: pattern.description)
                            // If PatternCard is not centered by default, apply centering here if needed
                        }
                    }
                    .padding(.bottom, 85)
                }
            }
        }
    }
}

struct PatternsView_Previews: PreviewProvider {
    static var previews: some View {
        PatternsView()
    }
}
