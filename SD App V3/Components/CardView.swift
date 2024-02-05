//
//  CardView.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/4/24.
//

import SwiftUI

struct CardView: View {
    var imageName: String
    var title: String
    var description: String

    var body: some View {
        ZStack {
//            Color(.systemGray5).ignoresSafeArea()
            
            HStack(spacing: 10) {
                Image(systemName: imageName) // Replace with your image name or use systemName for SF Symbols
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipped()
                    .cornerRadius(10)
                    .padding(10)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
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
            .background(Color.white) // Card background color
            .cornerRadius(15) // Card corner radius
            .padding(.horizontal, 10) // Add padding around the card to center it in its parent view
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(imageName: "paperplane", title: "This is a placeholder", description: "This is also a placehodler")
    }
}
