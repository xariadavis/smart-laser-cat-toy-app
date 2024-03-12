//
//  FavoritesCarousel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/9/24.
//

import SwiftUI
import Kingfisher

struct FavoritesCarousel: View {
    var width: CGFloat
    var height: CGFloat
    
    @ObservedObject var patternsManager = PatternsManager.shared

    var favoritePatterns: [LaserPattern] {
        patternsManager.patterns.filter { $0.isFavorite }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(favoritePatterns) { pattern in
                    CarouselItemView(pattern: pattern, width: width, height: height)
                        .frame(width: width, height: height)
                        .background(Color.fromNeuroKit)
                        .cornerRadius(12)
                }
            }
        }
    }
}

struct CarouselItemView: View {
    let pattern: LaserPattern
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        VStack {
            KFImage(URL(string: pattern.iconName))
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .scaledToFill()
                .frame(width: width * 0.5, height: height * 0.5)
                .clipped()
                .cornerRadius(10)
                .padding(5)

            Text(pattern.name)
                .font(Font.custom("Quicksand-Semibold", size: 14)) // May adjust size for better fit
                .fontWeight(.bold)
                .frame(width: width * 0.9)
                .padding(.horizontal, 5)
            
        }
        .padding(.bottom, 10)
    }
}


struct FavoritesCarousel_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesCarousel(width: 150, height: 150)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
