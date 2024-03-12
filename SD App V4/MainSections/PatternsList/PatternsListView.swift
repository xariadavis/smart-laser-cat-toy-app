//
//  PatternsListView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI

struct PatternsView: View {
    
    @StateObject private var viewModel = PatternsViewModel()
    
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
                            .padding(.bottom, 15)
                        
                        Text("All Patterns")
                            .font(Font.custom("TitanOne", size: 23))
                            .padding(.horizontal, 30)
                        
                        // List of Patterns centered
                        ForEach(viewModel.patterns) { pattern in
                            PatternCard(pattern: pattern)
                            // If PatternCard is not centered by default, apply centering here if needed
                        }
                    }
                    .padding(.bottom, 85)
                }
            }
        }
        .onAppear {
            viewModel.fetchPatterns()
        }
    }
}

struct PatternsView_Previews: PreviewProvider {
    static var previews: some View {
        PatternsView()
    }
}
