//
//  WelcomeView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/9/24.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var navigationState: NavigationState

    
    var body: some View {

        ZStack {
            
            // Background color
            Color(.systemGray5).ignoresSafeArea()
            
            VStack {
                
                // Welcome label
                Text("Welcome")
                    .font(Font.custom("TitanOne", size: 65))
                    .foregroundColor(Color.primary)
                
                 // Some type of catch phrase
                 Text("Smart Laser Toy for Cats")
                    .font(Font.custom("Quicksand-SemiBold", size: 20))
                    .foregroundColor(Color.primary.opacity(0.7))
                
                Spacer()
                
               ZStack {
                   LottiePlusView(name: colorScheme == .dark ? Constants.GingerHunt_Dark : Constants.GingerHunt, loopMode: .loop)
                   LottiePlusView(name: Constants.LaserDots, loopMode: .loop, animationSpeed: 2)
                       .frame(width: 125)
                       .offset(x: 50, y: 210)
                }

                Spacer()
                
                Button(action: {
                    navigationState.path.append(AuthenticationNavigation.register)
                }, label: {
                    Text("Sign Up")
                        .redButton()
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.red, lineWidth: 4)
                                .glow()
                                .shadow(color: Color.red.opacity(0.3), radius: 5)
                                .shadow(color: Color.red.opacity(0.3), radius: 10)
                                .shadow(color: Color.red.opacity(0.3), radius: 15)
                                .shadow(color: Color.red.opacity(0.3), radius: 20)
                        )
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                })
                
                Button(action: {
                    navigationState.path.append(AuthenticationNavigation.login)
                }, label: {
                    Text("Log In")
                        .redOutlineButton()
                        .padding(.horizontal, 40)
                })
                
            }
            .padding(.vertical)
            
        }
    }
}


#Preview {
    WelcomeView()
        .environmentObject(NavigationState())
}
