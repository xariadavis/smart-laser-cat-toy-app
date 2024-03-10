//
//  FavoritesCarousel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/9/24.
//

import SwiftUI

struct FavoritesCarousel: View {
    var width: CGFloat
    var height: CGFloat

    var favoritePatterns: [LaserPattern] {
        laserPatterns.filter { $0.isFavorite }
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
            Image(pattern.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: width * 0.8, height: height * 0.7) // Allocate 70% of height to image
                .clipped()
                .cornerRadius(10)

            Text(pattern.name)
                .font(Font.custom("Quicksand-Semibold", size: 14)) // May adjust size for better fit
                .fontWeight(.bold)
                .lineLimit(1) // Ensure text is limited to a single line
                .truncationMode(.tail) // If text is too long, it will be truncated at the end
                .padding(.horizontal, 5)
                .frame(width: width * 0.9) // Allocate full width for text, adjust as needed
        }
        .padding(5)
        .frame(width: width, height: height) // Explicitly set the item's frame
    }
}


struct FavoritesCarousel_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesCarousel(width: 300, height: 150)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
