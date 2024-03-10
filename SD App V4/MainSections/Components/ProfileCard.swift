//
//  ProfileCard.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/9/24.
//

import SwiftUI

struct ProfileCard: View {
    // @EnvironmentObject var userViewModel: UserViewModel
    
    private let cardCornerRadius: CGFloat = 20
    private let maxWidth = UIScreen.main.bounds.width - 50
    private let maxHeight: CGFloat = 450
    
    private var cardGradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
    }
    
    private var laserStrokeGradient: LinearGradient {
        let colors = [Color.red.opacity(0.5), Color.red, Color.red.opacity(0.5)]
        return LinearGradient(gradient: Gradient(colors: colors), startPoint: gradientStart, endPoint: gradientEnd)
    }
    
    @State private var gradientStart = UnitPoint(x: -0.5, y: -0.5)
    @State private var gradientEnd = UnitPoint(x: 0, y: 0)
    
    var body: some View {
        ZStack(alignment: .leading) {
            cardBackground
            profileImage
            cardGradient.clipShape(RoundedRectangle(cornerRadius: cardCornerRadius))
            // userInfo
        }
        .frame(width: maxWidth, height: maxHeight)
        .padding(5)
        .onAppear { animateLaserGradient() }
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: cardCornerRadius)
            .fill(Color.white)
            .frame(width: maxWidth, height: maxHeight)
            .shadow(radius: 7)
            .overlay(
                RoundedRectangle(cornerRadius: cardCornerRadius)
                    .stroke(laserStrokeGradient, lineWidth: 10)
            )
    }
    
    private var profileImage: some View {
        Image("MOCK_PFP")
            .resizable()
            .scaledToFill()
            .frame(width: maxWidth, height: maxHeight)
            .clipShape(RoundedRectangle(cornerRadius: cardCornerRadius))
    }
    
//    private var userInfo: some View {
//        VStack {
//            Spacer()
//            if let user = userViewModel.currentUser {
//                userInfoText(user.name)
//            } else {
//                userInfoText("Error finding name")
//            }
//        }
//        .padding(20)
//    }
    
    private func userInfoText(_ text: String) -> some View {
        Text(text)
            .font(Font.custom("QuickSand-Bold", size: 20))
            .foregroundColor(.white)
            .padding(.horizontal, 5)
    }
    
    private func animateLaserGradient() {
        withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: true)) {
            gradientStart = UnitPoint(x: 1.5, y: 1.5)
            gradientEnd = UnitPoint(x: 2, y: 2)
        }
    }
}

struct ProfileCard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCard()
            .previewLayout(.sizeThatFits)
    }
}
