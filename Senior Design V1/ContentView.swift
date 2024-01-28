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
            Color("Background").ignoresSafeArea()
            
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
                    .padding(.top , -285)
                    .offset(y: -60)
                    
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
                    .opacity(0.60)
                    .frame(width: .infinity)
                    .padding(-75) // Overlapping by half
                    .offset(y: 450)
                    .glow()
                
                // Welcome text
                Text("Welcome")
                    .font(Font.custom("TitanOne", size: 65))
                    .foregroundColor(.white)
                
                Text("Laser Beams and Kitty Dreams")
                    .font(Font.custom("Nunito-Regular", size: 20))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                Button("Sign Up") {}
                    .font(Font.custom("Nunito-Regular", size: 20))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(40)
                    .padding(.horizontal, 60)
                
                Button("Login") {}
                    .font(Font.custom("Nunito-Regular", size: 20))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(40)
                    .padding(.horizontal, 60)


            }
            .padding(.bottom, 100)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

