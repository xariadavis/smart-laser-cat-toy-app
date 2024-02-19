//
//  DashboardView.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/4/24.
//

import SwiftUI
import Neumorphic

struct DashboardView: View {
    @State var progressValue: Float = 0.3
    @Binding var selectedIndex: Int
    
    var body: some View {
            ZStack(alignment: .center) {
                
                
                // Background color
                Color(.systemGray5).ignoresSafeArea()
                
                VStack {
                    
                    VStack {
                        // Temp Text aligned to the left
                        Text("Dashboard")
                            .font(Font.custom("TitanOne", size: 30))
                            .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                            .padding(.horizontal, 30)
                            .padding(.top, 10)
                    }
                
                    ScrollView {
                        VStack {
                            
                            // Kitty Profile Card centered
                            ProfileCard()
                                .padding(.bottom, 15)
                            
                            // Activity Card Title aligned to the left
                            Text("Activity")
                                .font(Font.custom("TitanOne", size: 25))
                                .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                                .padding(.horizontal, 30)
                            
                            // Activity Card centered
                            ActivityCard()
                                .padding(.horizontal, 20)
                                .padding(.bottom, 15)
                            
                            
                            // Patterns Title aligned to the left
                            Text("Favorites")
                                .font(Font.custom("TitanOne", size: 25))
                                .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                                .padding(.horizontal, 30)
                            
                            // List of Patterns centered
                            ForEach(laserPatterns.filter {$0.isFavorite}) { pattern in
                                PatternCard(iconName: pattern.iconName, name: pattern.name, description: pattern.description)
                                
                            }
                            
                            Button("See more") {
                                selectedIndex = 1
                            }

                        }
                        .padding(.bottom, 85)
                    }
            }
        }
    }
}

//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView(selectedIndex: $selectedIndex)
//    }
//}
