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
    @ObservedObject var userCatsViewModel = UserCatsViewModel.shared


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
                        
                        Text("Account details")
                            .font(Font.custom("TitanOne", size: 25))
                            .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                        
                        Group {
                            
                            Text("User")
                                .font(Font.custom("TitanOne", size: 18))
                                .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                                .padding(.horizontal, 30)
                                .foregroundColor(Color.primary.opacity(0.7))
                            
                            List {
                                SettingsCard(iconImage: "person", name: "testing")
                                    .padding(.horizontal, 20)
                                SettingsCard(iconImage: "heart", name: "testing")
                                    .padding(.horizontal, 20)
                            }
                            //.listStyle(InsetGroupedListStyle())
                        }
                        
                        
                        Group {
                            Text("Cat")
                                .font(Font.custom("TitanOne", size: 18))
                                .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                                .padding(.horizontal, 30)
                                .foregroundColor(Color.primary.opacity(0.7))
                        }
                        // User
                            // name
                            // email
                            // password?
                        // Cat
                            // name
                            // age
                            // weight
                        
                        Spacer()

                        Button {
                            viewModel.logOut()
                            sessionManager.isUserAuthenticated = false
                            sessionManager.currentUser = nil
                            
                            userCatsViewModel.nullifyCat()
                            userCatsViewModel.nullifyUser()
                            
                            bluetoothViewModel.isSearching = false
                            bluetoothViewModel.isConnected = false
                        } label: {
                            Text("Log out")
                                .font(Font.custom("Quicksand-SemiBold", size: 20))
                                .frame(maxWidth: .infinity)
                                .padding(15)
                                .foregroundColor(Color.primary)
                                .background(Color.red.opacity(0.9))
                                .cornerRadius(30)
                                .padding(.horizontal, 20)
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
