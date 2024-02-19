//
//  FavoritesCarousel.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/19/24.
//

import SwiftUI

struct FavoritesCarousel: View {
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(laserPatterns.filter {$0.isFavorite}) { pattern in
                    CarouselItemView(pattern: pattern, width: width / 2, height: height / 2)
                        .frame(width: width, height: width)
                        .background(Color.Neumorphic.main)
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
                .scaledToFill()
                .frame(width: width, height: height)
                .clipped()
                .cornerRadius(10)
                .padding(5)
            
            Text(pattern.name)
                .font(Font.custom("Quicksand-Semibold", size: 15))
                .padding(.horizontal, 5)
        }
    }
}

struct FavoritesCarousel_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesCarousel(width: 150, height: 150)
    }
}
