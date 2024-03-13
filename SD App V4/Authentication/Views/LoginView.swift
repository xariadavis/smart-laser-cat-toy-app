//
//  LoginView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var navigationState: NavigationState
    @StateObject var viewModel: LoginViewModel
    @ObservedObject var patternsManager = PatternsManager.shared
    
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
                        .generalTextfield()
                    
                    SecureField("Password", text: $password)
                        .generalTextfield()
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
                    
                    print("Attempting to log in...")

                    viewModel.login(email: email, password: password)
                    patternsManager.fetchPatterns()
                    
                    
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
            .onChange(of: viewModel.isAuthenticated) { isAuthenticated in
                if isAuthenticated {
                    navigationState.path.append(AuthenticationNavigation.root)
                    
                } else {
                    // This might not be necessary, depending on your logic for handling authentication state
                    print("LoginView: Something went wrong")
                }
            }
            .alert("Login Error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.alertMessage)
            }
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(authViewModel: AuthViewModel()))
        .environmentObject(NavigationState())
}
