//
//  ForgotPasswordView.swift
//  SD App V3
//
//  Created by Xaria Davis on 3/1/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var showAlert: Bool = false

    var body: some View {
        ZStack {
            
            Color(.systemGray6).ignoresSafeArea()
            
            VStack(spacing: 15) {

                Text("Forgot Password")
                    .font(Font.custom("Quicksand-Semibold", size: 25))
                    .foregroundColor(.primary)
                    .padding(.bottom, 20)
                
                Text("We'll send you a link to the\nemail address you signed up with.")
                    .multilineTextAlignment(.center)
                    .font(Font.custom("Quicksand-Regular", size: 20))
                    .foregroundColor(.secondary)
                
                // Include textfield
                TextField("Email Address", text: $email)
                    .font(Font.custom("Quicksand-SemiBold", size: 20))
                    .foregroundColor(.primary)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(20)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .padding(.horizontal, 30)
                
                VStack {
                    Button {
                        print("This is the forget password button")
                        Task {
                            await authViewModel.resetPassword(email: email)
                        }
                    } label: {
                        Text("Continue")
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
                            .padding(.horizontal, 30)
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("in ForgotPasswordView"), message: Text(authViewModel.message ?? "Message"), dismissButton: .default(Text("OK")))
                }
                .syncBool($authViewModel.showAlert, with: $showAlert)
                
                Spacer()
                
            }
            .padding(.top, 50)
        }
    }
}

//struct ForgotPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        let authViewModel = AuthViewModel()
//        // Attach the AuthViewModel as an environment object
//        ForgotPasswordView().environmentObject(authViewModel)
//    }
//}
