//
//  PatternCard.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/9/24.
//

import SwiftUI
import Kingfisher
import PopupView

struct PatternCard: View {
    
    var pattern: LaserPattern
    @ObservedObject var patternsManager = PatternsManager.shared
    var onSingleTap: () -> Void
    @EnvironmentObject var timerViewModel: TimerViewModel

    var body: some View {
        HStack(spacing: 10) {
            KFpatternIcon
            
            VStack(alignment: .leading, spacing: 10) {
                patternTitle
                patternDescription
            }
        }
        .padding(10)
        .background(Color.fromNeuroKit)
        .cornerRadius(20)        
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(timerViewModel.currentPattern?.id == pattern.id ? Color.red : Color.clear, lineWidth: 2)
        )
        .padding(.horizontal)
        .onTapGesture(count: 2) {
            print("Double tapped!")
            patternsManager.toggleFavorite(for: pattern.id ?? "")
        }
        .simultaneousGesture(TapGesture().onEnded {
            onSingleTap()  // Execute the single tap action
        })
    }
    
    private var KFpatternIcon: some View {
        KFImage(URL(string: pattern.iconName))
            .placeholder {
                LottiePlusView(name: Constants.LaserLoading)
            }
            .resizable()
            .scaledToFit()
            .frame(width: 70, height: 70)
            .clipped()
            .cornerRadius(10)
            .padding(5)
    }

    private var patternTitle: some View {
        HStack {
            Text(pattern.name)
                .font(Font.custom("Quicksand-Bold", size: 17))
                .fontWeight(.bold)
                .padding(.top, 10)
            
            Spacer()
            
            if pattern.isFavorite {
                Image("Sparkle") // Example image name, replace with actual favorite icon if different
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.horizontal, 5)
            }
        }
    }

    private var patternDescription: some View {
        Text(pattern.description)
            .font(Font.custom("Quicksand-Bold", size: 14))
            .foregroundColor(.secondary)
            .lineLimit(3)
            .padding(.bottom, 10)
    }
}

struct PatternCard_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var patternsManager = PatternsManager.shared

        PatternCard(pattern: patternsManager.patterns[2], onSingleTap: {
            print("Single Tapped")
        })
    }
}

