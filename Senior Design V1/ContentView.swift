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
            LottiePlusView(name: Constants.welcomeKitty,
                       loopMode: .loop)
            .frame(width: 300)
            
            VStack {
                // Welcome text
                Text("Welcome").font(Font.custom("TitanOne", size: 50))
                Text("Where Technology Meets Kitty Play").font(Font.custom("Nunito-Regular", size: 20))
                // Text("Laser Beams and Kitty Dreams...")
                Spacer()
            }
            .padding(.top, 20)
            
            VStack {
                Spacer()
                Button("Login") {
                    print("Login button clicked")
                }
                    .buttonStyle(.borderedProminent)
                
                Button("Sign Up") {
                    print("Sign Up button clicked")
                }
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

