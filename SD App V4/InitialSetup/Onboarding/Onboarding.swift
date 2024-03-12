//
//  Onboarding.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/11/24.
//

import SwiftUI

struct Onboarding: View {
    @ObservedObject private var sharedInfo = SharedRegistrationInfo.shared
        
    var body: some View {
        ZStack {
            
            Color(.systemGray5).ignoresSafeArea()
            
            VStack {
                
                Text("How old is \(String(describing: sharedInfo.catName))")
                    .font(Font.custom("Quicksand-Bold", size: 30))

                
                Spacer()
                
                // Sign Up
                Button(action: {
                    
                }, label: {
                    Text("Next")
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .foregroundColor(Color.primary)
                        .background(Color.red.opacity(0.9))
                        .cornerRadius(40)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                })
            }
            .padding()
        }
    }
}

struct CatNameView: View {
    var body: some View {
        Text("How old is CATNAME")
    }
}

#Preview {
    Onboarding()
}
