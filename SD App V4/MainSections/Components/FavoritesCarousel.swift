//
//  FavoritesCarousel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/9/24.
//

import SwiftUI
import Kingfisher

struct FavoritesCarousel: View {
    
    @ObservedObject var patternsManager = PatternsManager.shared
    
    var width: CGFloat
    var height: CGFloat
    
    var favoritePatterns: [LaserPattern] {
        patternsManager.patterns.filter { $0.isFavorite }
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
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel
    @ObservedObject var userCatsViewModel = UserCatsViewModel.shared
    @ObservedObject var patternsManager = PatternsManager.shared
    
    let pattern: LaserPattern
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        VStack {
            KFImage(URL(string: pattern.iconName))
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .scaledToFill()
                .frame(width: width * 0.5, height: height * 0.5)
                .clipped()
                .cornerRadius(10)
                .padding(5)

            Text(pattern.name)
                .font(Font.custom("Quicksand-Semibold", size: 14)) // May adjust size for better fit
                .fontWeight(.bold)
                .frame(width: width * 0.9)
                .padding(.horizontal, 5)
            
        }
        .padding(.bottom, 10)
        .gesture(
            TapGesture(count: 2).onEnded {
                print("Double tapped!")
                
                patternsManager.toggleFavorite(for: self.pattern.id ?? "", userId: userCatsViewModel.user.id, catId: userCatsViewModel.cat.id ?? "")
            }.exclusively(before: TapGesture(count: 1).onEnded {
                // print("Single tapped!")
                
                timerViewModel.currentPattern = self.pattern
                timerViewModel.showingPatternCover = true
                bluetoothViewModel.writeOmegaValues(omega1: Int32(pattern.omega_1), omega2: Int32(pattern.omega_2))

                print("omega_1: \(pattern.omega_1) -- omega_2: \(pattern.omega_2)")
            })
        )
    }
}


struct FavoritesCarousel_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesCarousel(width: 150, height: 150)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
