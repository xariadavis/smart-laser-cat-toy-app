//
//  SignUpView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var navigationState: NavigationState
    @EnvironmentObject var sessionManager: SessionManager
    
    @StateObject var viewModel: SignUpViewModel
    
    @State private var opacity = 0.0
    @State private var ownerName: String = ""
    @State private var catName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @FocusState private var focusedField: Field?

    enum Field {
        case ownerName, catName, email, password
    }
    
    
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
                        .focused($focusedField, equals: .ownerName)
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(15)
                        .autocorrectionDisabled(true)

                    
                    TextField("Pet's Name", text: $catName)
                        .focused($focusedField, equals: .catName)
                        .onSubmit { focusedField = .email }
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(15)
                        .autocorrectionDisabled(true)
                    
                    TextField("Email Address", text: $email)
                        .focused($focusedField, equals: .email)
//                        .textContentType(.emailAddress)
//                        .keyboardType(.emailAddress)
                        .textFieldStyle(.plain)
                        .textContentType(.oneTimeCode) // Content type that doesn't trigger passwords auto-fill, but this might not be ideal for user experience
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(15)
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                    
                    
                    SecureField("Password", text: $password)
                        .focused($focusedField, equals: .password)
//                        .textContentType(.password)
                        .textFieldStyle(.plain)
                        .textContentType(.oneTimeCode) // Content type that doesn't trigger passwords auto-fill, but this might not be ideal for user experience
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(15)
                    
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                
                // Sign Up
                Button(action: {
                    
                    // When calling register from your view or button action
                    viewModel.register(name: ownerName, email: email, password: password, catName: catName) { success, error in
                        if success {
                            // Now that registration is successful, navigate to the onboarding view
                            DispatchQueue.main.async {
                                navigationState.path.append(AuthenticationNavigation.onboarding(catName: catName))
                                // sessionManager.currentUser?.id = viewModel.userID
                            }
                        } else {
                        // Handle registration failure, potentially by showing an error message
                        print("SignUpView: Registration failed with error: \(error?.localizedDescription ?? "Unknown error")")
                        }
                    }

                    print("SignUpView: onChange is \(viewModel.registrationSuccessful)")
                    print("In sign up view: \(viewModel.userID)")
                    
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
                
                
                // Go to log in
                Button(action: {
                    navigationState.path.append(AuthenticationNavigation.login)
                }, label: {
                    Text("Already have an account? Log in")
                        .padding(.vertical, 10)
                        .font(Font.custom("Quicksand-SemiBold", size: 17))
                })
                
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
    SignUpView(viewModel: SignUpViewModel(authViewModel: AuthViewModel(), firestoreManager: FirestoreManager()))
        .environmentObject(NavigationState())
}
