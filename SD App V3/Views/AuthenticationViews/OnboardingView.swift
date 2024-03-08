//
//  OnboardingView.swift
//  SD App V3
//
//  Created by Xaria Davis on 3/6/24.
//

import SwiftUI


struct OnboardingView: View {
    
    @State var onboardingState: Int = 0
    
    var body: some View {
        
        // Need pages for:
            // Age
            // Weight
            // Sex
            // Breed
            // Add photo
        
        ZStack {
                        
            Color(hex: "fa5456").ignoresSafeArea()
            
            VStack {
                ageSection
                Spacer()
                onboardingButton
            }
            
        }
        
    }
}

#Preview {
    OnboardingView()
}

extension OnboardingView {
    
    // Button styling
    private var onboardingButton: some View {
        Button(action: {
            print("onBoarding button pressed")
        }, label: {
            Text("Next")
                .font(Font.custom("Quicksand-Bold", size: 23))
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.black)
                .cornerRadius(20)
                .padding(20)
        })
    }
    
    // Age View
    private var ageSection: some View {
        VStack {
            
            Text("How old is \(UserDefaults.standard.string(forKey: "name") ?? "your cat?")")
                .font(Font.custom("Quicksand-Bold", size: 30))
                .foregroundStyle(.white)
            
            // add picker
            
        }
    }
    
    // Weight View
    
    // Sex View
    
    // Breed View
    
}
