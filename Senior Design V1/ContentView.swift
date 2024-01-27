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
                VStack{
                    
                    LottiePlusView(name: Constants.stars,
                                   loopMode: .loop)
                    .scaledToFill()
                    .frame(width: 450)
                    .padding(.top, -100)
                    .ignoresSafeArea()
                    
                    LottiePlusView(name: Constants.tigerAstronaut,
                                   loopMode: .loop)
                    .scaledToFill()
                    .frame(width: 450)
                    .padding(.top , -285)
                    .offset(y: -25)
                    
                    LottiePlusView(name: Constants.stars,
                                   loopMode: .loop)
                    .scaledToFill()
                    .frame(width: 450)
                    .padding(.top, -75)
                    
                }
                .padding(.top, 20)
            }
            
            VStack {
                Spacer()
                
                Circle()
                    .fill(Color.red)
                    .opacity(0.75)
                    .frame(width: 600)
                    .padding(-75) // Overlapping by half
                    .offset(y: 425)
                    .glow()
                
                // Welcome text
                Text("Welcome")
                    .font(Font.custom("TitanOne", size: 65))
                    .foregroundColor(.white)
                
                Text("Laser Beams and Kitty Dreams")
                    .font(Font.custom("Nunito-Regular", size: 20))
                    .foregroundColor(.white)
                
                Button("Sign Up") {}
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(Font.custom("Nunito-Regular", size: 20))
                    .tint(.blue)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                
                Button("Login") {}
                    .font(Font.custom("Nunito-Regular", size: 20))
                    .tint(.blue)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
            }
            .padding(.bottom, 125)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

