//
//  DashboardView.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/4/24.
//

import SwiftUI
import Neumorphic

struct DashboardView: View {
    var body: some View {
        ZStack(alignment: .center) {
            
            // Background color
            Color(.systemGray5).ignoresSafeArea()

            ScrollView {
                VStack {
                    
                    // Temp Text aligned to the left
                    Text("Happy Playing")
                        .font(Font.custom("TitanOne", size: 25))
                        .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                        .padding(.horizontal, 30)

                    // Kitty Profile Card centered
                    ProfileCard()
                        .padding(.bottom, 15)
                    
                    // Activity Card Title aligned to the left
                    Text("Activity")
                        .font(Font.custom("TitanOne", size: 25))
                        .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                        .padding(.horizontal, 30)

                    // Activity Card centered
                    ListCard()
                        .padding(.bottom, 15)
                    
                    // Patterns Title aligned to the left
                    Text("Patterns")
                        .font(Font.custom("TitanOne", size: 25))
                        .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                        .padding(.horizontal, 30)

                    // List of Patterns centered
                    ForEach(laserPatterns) { pattern in
                        PatternCard(iconName: pattern.iconName, name: pattern.name, description: pattern.description)
                            // If PatternCard is not centered by default, apply centering here if needed
                    }
                }
                .padding([.leading, .trailing], 20)  // Add padding to the left and right if desired

            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
