//
//  ContentView.swift
//  Senior Design V1
//
//  Created by Xaria Davis on 1/17/24.
//

import SwiftUI

struct ContentView: View {
        
    var body: some View {
        ZStack {
            Color(.systemGray5).ignoresSafeArea()
    
            VStack {
                Circle()
                .fill(Color.red)
                .frame(width: 600)
                .padding(-75) // Overlapping by half
                .offset(y: 175)
                .glow()
            }
            
            VStack {
                
                VStack{
                    LottiePlusView(name: Constants.welcomeKitty,
                               loopMode: .loop)
                    .scaledToFit()
                    .frame(width: 300)
                }
                .padding(.top, 15)
                
                VStack {
                    // Welcome text
                    Text("Welcome").font(Font.custom("TitanOne", size: 50))
                    Text("Where Technology Meets Kitty Play").font(Font.custom("Nunito-Regular", size: 20))
                    // Text("Laser Beams and Kitty Dreams...")
                }
                .padding(.top, 150)
                
                Spacer()
                
                Button("Sign Up") {}
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(Font.custom("Nunito-Regular", size: 20))
                    .tint(.blue)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .controlSize(.large)
                
                Button("Login") {}
                    .font(Font.custom("Nunito-Regular", size: 20))
                    .tint(.blue)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .controlSize(.large)
                
            }
            .padding(.bottom, 30)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

