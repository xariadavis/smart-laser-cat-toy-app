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
                    .font(Font.custom("TitanOne", size: 60))
                    .foregroundColor(Color.primary)
                
                // Some type of catch phrase
                Text("Insert catch phrase")
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
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .foregroundColor(Color.primary)
                        .background(Color.red.opacity(0.9))
                        .cornerRadius(30)
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
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .foregroundColor(Color.primary)
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .cornerRadius(30)
                        .contentShape(Rectangle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.red.opacity(0.9), lineWidth: 2)
                                // Apply glow effect
                                .shadow(color: Color.red.opacity(0.3), radius: 10, x: 0, y: 0)
                                .shadow(color: Color.red.opacity(0.3), radius: 20, x: 0, y: 0)
                                .shadow(color: Color.red.opacity(0.3), radius: 30, x: 0, y: 0)
                                .shadow(color: Color.red.opacity(0.3), radius: 40, x: 0, y: 0)
                        )
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
