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
            
            ScrollView {
                // List of Patterns centered
                ForEach(laserPatterns) { pattern in
                    PatternCard(iconName: pattern.iconName, name: pattern.name, description: pattern.description)
                    // If PatternCard is not centered by default, apply centering here if needed
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
