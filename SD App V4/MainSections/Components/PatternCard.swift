//
//  PatternCard.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/9/24.
//

import SwiftUI
import Kingfisher

struct PatternCard: View {
    let pattern: LaserPattern

    var body: some View {
        HStack(spacing: 10) {
            KFpatternIcon
            
            VStack(alignment: .leading, spacing: 10) {
                patternTitle
                patternDescription
            }
        }
        .padding(10)
        .background(Color.fromNeuroKit)
        .cornerRadius(20)
        .padding(.horizontal)
    }
    
    private var KFpatternIcon: some View {
        KFImage(URL(string: pattern.iconName))
            .placeholder {
                ProgressView()
            }
            .resizable()
            .scaledToFit()
            .frame(width: 70, height: 70)
            .clipped()
            .cornerRadius(10)
            .padding(5)
    }

    private var patternTitle: some View {
        HStack {
            Text(pattern.name)
                .font(Font.custom("Quicksand-Bold", size: 17))
                .fontWeight(.bold)
                .padding(.top, 10)
            
            Spacer()
            
            if pattern.isFavorite {
                Image("Sparkle") // Example image name, replace with actual favorite icon if different
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.horizontal, 5)
            }
        }
    }

    private var patternDescription: some View {
        Text(pattern.description)
            .font(Font.custom("Quicksand-Bold", size: 14))
            .foregroundColor(.secondary)
            .lineLimit(3)
            .padding(.bottom, 10)
    }
}

struct PatternCard_Previews: PreviewProvider {
    static var previews: some View {
        let _: LaserPattern
        
        PatternCard(pattern: laserPatterns[2])
    }
}

