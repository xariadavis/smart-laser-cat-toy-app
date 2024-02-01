//
//  RegisterView.swift
//  SD App V3
//
//  Created by Xaria Davis on 1/30/24.
//

import SwiftUI

struct RegisterView: View {
    
    let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.midBlue.opacity(0.15), Color(.systemGray6), Color.white.opacity(0.2)]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    @State private var fullName = ""
    @State private var petName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var wrongEmail = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var opacity = 0.0
    
    @FocusState private var isTextFieldFocused: Bool
        
    var body: some View {
        ZStack {
            
            gradient.ignoresSafeArea()
            LottiePlusView(name: Constants.LaserDots, loopMode: .loop, animationSpeed: 0.7)
                .blur(radius: 5)
                .frame(width: 250)
                .offset(x: -90, y: -150)
                .rotationEffect(.degrees(210))
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.4)) {
                        opacity = 1
                    }
                }
            
            VStack {
                
                VStack(alignment: .leading) {
                    
//                    if !isTextFieldFocused {
                        Text("Welcome to\nappName!")
                            .font(Font.custom("TitanOne", size: 50))
                            .multilineTextAlignment(.leading)
//                    }
                    
                    TextField("Full Name", text: $fullName)
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(15)
                        .focused($isTextFieldFocused)
                    
                    TextField("Pet's Name", text: $petName)
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(15)
                        .focused($isTextFieldFocused)
                    
                    TextField("Email Address", text: $email)
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(15)
                        .focused($isTextFieldFocused)
                    
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
                
                
                Spacer()
                
                NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)) {
                    Text("Sign Up")
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .foregroundColor(Color.primary)
                        .background(Color.red.opacity(0.9))
                        .cornerRadius(40)
                    
                        // Apply glowing border effect
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.red, lineWidth: 2)
                        )
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                }
                .buttonStyle(PlainButtonStyle())
  
                // Make this a link
                NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true)) {
                    HStack (spacing: 4) {
                        Text("Already have an account?")
                            .foregroundColor(.midBlue)
                            .padding(.vertical, 10)
                            .font(Font.custom("Quicksand-SemiBold", size: 17))
                        Text("Login")
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
