//
//  CardView.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/4/24.
//

import SwiftUI

struct PatternCard: View {
    var iconName: String
    var name: String
    var description: String

    var body: some View {
        ZStack {
            
            HStack(spacing: 10) {
                
                Image(iconName) // Replace with your image name or use systemName for SF Symbols
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipped()
                    .cornerRadius(10)
                    .padding(5)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(name)
                        .font(Font.custom("Quicksand-Bold", size: 17))
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Text(description)
                        .font(Font.custom("Quicksand-Bold", size: 14))
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .padding(.bottom, 10)
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
//            .background(Color.white) // Card background color
            .background(Color.Neumorphic.main)
            .cornerRadius(20) // Card corner radius
            .padding(.horizontal) // Add padding around the card to center it in its parent view
        }
    }
}

struct PatternCard_Previews: PreviewProvider {
    static var previews: some View {
        PatternCard(iconName: "CirclePattern", name: "This is a placeholder", description: "This is also a placehodler")
    }
}
