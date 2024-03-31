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
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel // Create an instance of BluetoothViewModel

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
                
                
                ScrollView {
                    VStack {
                        
                        // Patterns Title aligned to the left
                        Text("Device Status")
                            .font(Font.custom("TitanOne", size: 25))
                            .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                            .padding(.horizontal, 30)
                        
                        BluetoothCard()
                            .padding(.horizontal)
                        
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
            
        }
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel(authViewModel: AuthViewModel()))
}
