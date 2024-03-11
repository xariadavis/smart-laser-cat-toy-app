//
//  SignUpView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var navigationState: NavigationState
    @StateObject var viewModel: SignUpViewModel
    
    @State private var opacity = 0.0
    @State private var ownerName: String = ""
    @State private var petName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
    
        ZStack {
            
            Color(.systemGray6).ignoresSafeArea()
            
            
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
                
                Group {
                    Image("Icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                        .offset(x: 15)
                        .padding(.top, -10)
                    
                    Text("Sign Up!")
                        .font(Font.custom("TitanOne", size: 35))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 30)
                }
                                
                Group {
                    
                    TextField("Your Name", text: $ownerName)
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(15)
                    
                    TextField("Pet's Name", text: $petName)
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(15)
                    
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
                
                Spacer()
                
                Button(action: {
        
                    print("SignUpView: The email is \(email)")
                    print("SignUpView: The password is \(password)")
    
                    viewModel.register(name: ownerName, email: email, password: password)
                    
                    print("SignUpView: onChange is \(viewModel.registrationSuccessful)")
                    
                }, label: {
                    Text("Sign Up")
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .foregroundColor(Color.primary)
                        .background(Color.red.opacity(0.9))
                        .cornerRadius(40)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                })
                
                Button(action: {
                    navigationState.path.append(AuthenticationNavigation.login)
                }, label: {
                    Text("Already have an account? Log in")
                        .padding(.vertical, 10)
                        .font(Font.custom("Quicksand-SemiBold", size: 17))
                })
                
            }
            .onChange(of: viewModel.registrationSuccessful) { registrationSuccessful in
                if registrationSuccessful {
                    print("SignUpView: onChange is \(registrationSuccessful)")
                    navigationState.path.append(AuthenticationNavigation.onboarding)
                } else {
                    print("SignUpView: Something went wrong")
                }
            }
            .alert("Registration Error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.alertMessage)
            }
            
        }
    }
}

#Preview {
    SignUpView(viewModel: SignUpViewModel(authViewModel: AuthViewModel()))
        .environmentObject(NavigationState())
}
