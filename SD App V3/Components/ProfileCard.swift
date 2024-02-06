//
//  Card.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/4/24.
//

import SwiftUI

struct ProfileCard: View {
    
    let cardGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.5)])
    
    var body: some View {
        
        ZStack(alignment: .leading) {
//            RoundedRectangle(cornerRadius: 30)
//                .fill(Color.white)
//                .frame(width: 350, height: 350)
//                .shadow(radius: 7)
            
            Image("KittyProfilePic") // Replace "yourImageName" with the name of your image
                .resizable()
                .scaledToFill()
            
            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: UnitPoint.bottom)
            
            VStack() {
                Spacer()
                Text("Sir Walter Honey Bee 🐝")
                    .font(Font.custom("TitanOne", size: 20))
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
            }
            .padding(20)
        }
        .frame(width: 350, height: 350)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

struct ProfileCard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCard()
            .previewLayout(.sizeThatFits)
    }
}
