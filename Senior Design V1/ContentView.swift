//
//  ContentView.swift
//  Senior Design V1
//
//  Created by Xaria Davis on 1/17/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoginActive = false
    @State private var isRegisterActive = false
        
    var body: some View {
        NavigationView {
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
                    
                    GeometryReader { geometry in
                        
                        let height = geometry.size.height
                        let width = geometry.size.width
                        
                        Circle()
                            .fill(Color.red)
                            .opacity(0.65)
                            .frame(width: width * 1.5, height: height * 1.5)
                            .position(x: width / 2, y: (height / 2) + height * 1.05)
                            .glow()
                    }
                    
                    // Welcome text
                    Text("Welcome")
                        .font(Font.custom("TitanOne", size: 65))
                        .foregroundColor(.white)
                    
                    Text("Laser Beams and Kitty Dreams")
                        .font(Font.custom("Nunito-Regular", size: 20))
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    NavigationLink(destination: RegisterView(), isActive: $isRegisterActive) {
                        Button("Sign Up") {
                            self.isRegisterActive = true
                        }
                        .font(Font.custom("Nunito-Regular", size: 20))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(40)
                        .padding(.horizontal, 60)
                    }
                    
                    NavigationLink(destination: LoginView(), isActive: $isLoginActive) {
                        Button("Login") {
                            self.isLoginActive = true
                        }
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
                    
                }
                .padding(.bottom, 100)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

