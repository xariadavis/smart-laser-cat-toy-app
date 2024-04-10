//
//  PatternsListView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI

struct PatternsView: View {
    
    @ObservedObject var patternsManager = PatternsManager.shared
    @ObservedObject var userCatsViewModel = UserCatsViewModel.shared
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel
    
    var body: some View {
        ZStack {
            
            Color(.systemGray5).ignoresSafeArea()
            
            VStack() {
                
                // Title
                Text("Patterns")
                    .font(Font.custom("TitanOne", size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        
                        Text("Favorites")
                            .font(Font.custom("TitanOne", size: 23))
                            .padding(.horizontal, 30)
                        
                        Group {
                            if patternsManager.patterns.filter({ $0.isFavorite }).isEmpty {
                                Text("No favorites found. Double tap a pattern to add it to Favorites!")
                                    .font(Font.custom("Quicksand-Bold", size: 18))
                                    .multilineTextAlignment(.center) // Center-align the text
                                    .padding(50)
                            } else {
                                FavoritesCarousel(width: 175, height: 175)
                                    .padding(.horizontal)
                                    .padding(.bottom, 15)
                            }
                        }
                        
                        Text("All Patterns")
                            .font(Font.custom("TitanOne", size: 23))
                            .padding(.horizontal, 30)
                        
                        // List of Patterns centered
                        ForEach(patternsManager.patterns) { pattern in
                            PatternCard(pattern: pattern, userId: userCatsViewModel.user.id, catId: userCatsViewModel.cat.id ?? "")
                        }
                    }
                    .padding(.bottom, 85)
                }
            }
        }
        .sheet(isPresented: $timerViewModel.showingPatternCover) {
            if let pattern = timerViewModel.currentPattern {
                PatternDetailCover(pattern: .constant(pattern), isConnected: bluetoothViewModel.isConnected) {
                    timerViewModel.showingPatternCover = false
                }
            }
        }
    }
}

struct PatternsView_Previews: PreviewProvider {
    static var previews: some View {
        PatternsView()
    }
}
