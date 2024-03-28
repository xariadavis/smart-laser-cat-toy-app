//
//  SettingsView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        ZStack {
            
            Color(.systemGray5).ignoresSafeArea()
            
            VStack {
                
                // Title
                Text("Settings")
                    .font(Font.custom("TitanOne", size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                
                deviceView
                
                Spacer()
                
                Button {
                    viewModel.logOut()
                    sessionManager.isUserAuthenticated = false
                    sessionManager.currentUser = nil
                } label: {
                    Text("Log out")
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .foregroundColor(Color.primary)
                        .background(Color.red.opacity(0.9))
                        .cornerRadius(30)
                        .padding(.horizontal, 40)
                }
                
            }
            .padding(.bottom, 85)
        }
    }
    
    private var deviceView: some View {
        Text("Connection Status")
        return Button {
            print("Hello")
        } label: {
            Text("Connect to device")
        }

    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel(authViewModel: AuthViewModel()))
}
