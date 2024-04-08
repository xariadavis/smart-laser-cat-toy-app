//
//  ForgotPasswordView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/9/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @EnvironmentObject var navigationState: NavigationState
    @State var email: String = ""
    
    var body: some View {
        
        ZStack {
            
            Color(.systemGray6).ignoresSafeArea()
            
            VStack {
                
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
                
                Button(action: {
                    print("Send reset password email")
                }, label: {
                    Text("Continue")
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .foregroundColor(Color.primary)
                        .background(Color.red.opacity(0.9))
                        .cornerRadius(30)
                        .padding(.horizontal, 30)
                })
                
                Spacer()
                
            }
            .padding(.top, 50)
            
        }
        
    }
}

#Preview {
    ForgotPasswordView()
}
