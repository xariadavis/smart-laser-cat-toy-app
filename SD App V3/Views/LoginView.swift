//
//  LoginView.swift
//  SD App V3
//
//  Created by Xaria Davis on 1/30/24.
//

import SwiftUI

struct LoginView: View {
    
    let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.midBlue.opacity(0.15), Color(.systemGray6), Color.white.opacity(0.2)]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var wrongEmail = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var opacity = 0.0
    
    @FocusState private var isTextFieldFocused: Bool
        
    var body: some View {
        ZStack {
            
            // gradient.ignoresSafeArea()
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
                
                VStack(alignment: .leading) {
                    

                    Text("Welcome\nBack")
                        .font(Font.custom("TitanOne", size: 50))
                        .multilineTextAlignment(.leading)

                    
                    TextField("Email Address", text: $email)
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(15)
                        .focused($isTextFieldFocused)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    SecureField("Password", text: $password)
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(15)
                        .focused($isTextFieldFocused)
                }
                .padding(.top, 50)
                .padding(.horizontal, 30)
                
                
                // Make this a link
                NavigationLink {
                    ForgotPasswordView()
                } label: {
                    Text("Forgot Password?")
                        .padding(.top, 10)
                        .foregroundColor(.midBlue)
                        .font(Font.custom("Quicksand-Bold", size: 17))
                }

                
                Spacer()
                
                VStack {
                    Button {
                        Task {
                            await authViewModel.signIn(email: email, password: password)
                        }
                    } label: {
                        Text("Login")
                            .font(Font.custom("Quicksand-SemiBold", size: 20))
                            .frame(maxWidth: .infinity)
                            .padding(15)
                            .foregroundColor(Color.primary)
                            .background(Color.red.opacity(0.9))
                            .cornerRadius(30)
                        
                        // Apply glowing border effect
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                            .padding(.horizontal, 40)
                            .padding(.vertical, 10)
                    }
                }
                .alert(authViewModel.messageTitle ?? "Alert", isPresented: $authViewModel.showAlert, presenting: authViewModel.message) { detail in
                    Button("OK", role: .cancel) { }
                } message: { detail in
                    Text(detail)
                }

                NavigationLink(destination: RegisterView().navigationBarBackButtonHidden(true)) {
                    HStack (spacing: 4) {
                        Text("New here?")
                            .foregroundColor(.midBlue)
                            .padding(.vertical, 10)
                            .font(Font.custom("Quicksand-SemiBold", size: 17))
                        Text("Sign Up")
                            .foregroundColor(.midBlue)
                            .padding(.vertical, 10)
                            .font(Font.custom("Quicksand-SemiBold", size: 17))
                    }
                }

            }
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    opacity = 1.0
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
