//
//  DashboardView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var navigationState: NavigationState
    
    var body: some View {

        ZStack {
            
            Color(.systemGray5).ignoresSafeArea()
            
            ScrollView {
                
                ProfileCard()
                    .padding(.bottom, 15)
                
                // Activity Card Title aligned to the left
                Text("Activity")
                    .font(Font.custom("TitanOne", size: 25))
                    .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                    .padding(.horizontal, 30)
                
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
                    PatternCard(pattern: pattern)
                }
                
                Button(action: {
                    navigationState.path.append(MainNavigation.patternsList)
                }, label: {
                    HStack {
                        Text("See more")
                        Image(systemName: "arrow.right")
                    }
                    .font(Font.custom("Quicksand-SemiBold", size: 17))
                    .frame(maxWidth: .infinity)
                    .padding(15)
                    .foregroundColor(Color.primary)
                    .background(Color.red.opacity(0.0))
                    .cornerRadius(15)
                    .padding(.horizontal, 15)
                })
            }
        }
        .navigationTitle("Dashboard")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

#Preview {
    DashboardView()
}
