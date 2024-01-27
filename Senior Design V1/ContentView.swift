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
                    .padding(.top , -275)
                    
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
                
                // Welcome text
                Text("Welcome")
                    .font(Font.custom("TitanOne", size: 65))
                
                Text("Laser Beams and Kitty Dreams")
                    .font(Font.custom("Nunito-Regular", size: 20))
                    .padding(.bottom, 50)
                
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
            .padding(.bottom, 120)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

