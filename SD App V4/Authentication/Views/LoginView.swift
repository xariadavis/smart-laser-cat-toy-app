//
//  LoginView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var navigationState: NavigationState
    @State private var opacity = 0.0
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            
            Color(.systemGray6).ignoresSafeArea()
            
            LottiePlusView(name: Constants.LaserDots, loopMode: .loop, animationSpeed: 0.7)
                .blur(radius: 5)
                .frame(width: 250)
                .offset(x: -70, y: -150)
                .rotationEffect(.degrees(40))
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.4)) {
                        opacity = 1
                    }
                }
            
            VStack {
                
                Image("Icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .offset(x: 15)
                    .padding(.top, -10)
                
                Text("Welcome Back")
                    .font(Font.custom("TitanOne", size: 35))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
                
                
                Group {
                    TextField("Email Address", text: $email)
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(15)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    SecureField("Password", text: $password)
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(15)
                }
                .padding(.horizontal, 20)
                
                Button(action: {
                    navigationState.path.append(AuthenticationNavigation.forgotPassword)
                }, label: {
                    Text("Forgot Password?")
                        .font(Font.custom("Quicksand-Bold", size: 17))
                })
                
                Spacer()
                
                Button {
                    navigationState.path.append(AuthenticationNavigation.root)
                } label: {
                    Text("Login")
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .foregroundColor(Color.primary)
                        .background(Color.red.opacity(0.9))
                        .cornerRadius(30)
                        .padding(.horizontal, 40)
                }
                
                Button(action: {
                    navigationState.path.append(AuthenticationNavigation.register)
                }, label: {
                    Text("New Here? Sign Up")
                        .padding(.vertical, 10)
                        .font(Font.custom("Quicksand-SemiBold", size: 17))
                })
                
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(NavigationState())
}
