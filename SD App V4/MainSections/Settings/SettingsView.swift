//
//  SettingsView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI

enum UpdateOption {
    case usersName
    case email
    case catsName
    case age
    case weight
    case collarColor
}

struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel // Create an instance of BluetoothViewModel
    @ObservedObject var userCatsViewModel = UserCatsViewModel.shared
    
    @State private var selectedOption: UpdateOption?
    @State private var isUpdating: Bool = false

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
                            .padding(.top, 50)
                            .padding(.bottom, 10)
                        
                            
                        Text("User")
                            .font(Font.custom("TitanOne", size: 18))
                            .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                            .padding(.horizontal, 30)
                            .foregroundColor(Color.primary.opacity(0.7))
                        
                        VStack(spacing: 1) {
                            SettingsCard(iconImage: "person", name: "Name")
                                .onTapGesture {
                                    print("Name card tapped")
                                    self.isUpdating = true
                                }
                            SettingsCard(iconImage: "envelope", name: "Email")
                        }
                        .background(Color(.systemGray4))
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        
                        Text("Cat")
                            .font(Font.custom("TitanOne", size: 18))
                            .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                            .padding(.horizontal, 30)
                            .foregroundColor(Color.primary.opacity(0.7))
                        
                        VStack(spacing: 1) {
                            SettingsCard(iconImage: "cat", name: "Name")
                            SettingsCard(iconImage: "calendar", name: "Age")
                            SettingsCard(iconImage: "scalemass", name: "Weight")
                            SettingsCard(iconImage: "tag", name: "Collar Color")
                        }
                        .background(Color(.systemGray4))
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        .padding(.bottom, 40) // Remove if log out will not immediately follow
                        
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
        .fullScreenCover(isPresented: self.$isUpdating, content: {
            UpdatingView(settingsViewModel: viewModel)
        })
    }
}

// TODO: Implement selective refreshing
struct UpdatingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var updatedName: String = ""
    @ObservedObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        ZStack {
            
            Color(.systemGray5).ignoresSafeArea()
            
            VStack {
                
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 25))
                            .foregroundColor(Color.primary)
                            .padding()
                    }
                }
                
                Spacer()
                
                updateUsersName
                
                Spacer()
                Button(action: {
                    print("updating")
                    print("\(sessionManager.userCatsViewModel.cat.id)")
                    settingsViewModel.updateCatField(id: sessionManager.currentUser?.id ?? "", catID: sessionManager.userCatsViewModel.cat.id ?? "", updates: ["name" : updatedName])
                    
//                    settingsViewModel.updateUserField(id: sessionManager.currentUser?.id ?? "", updates: ["name" : updatedName])
                    sessionManager.refreshCurrentUser()
                }, label: {
                    Text("Update")
                        .redButton()
                        .padding(.horizontal, 20)
                })
                
            }
            
        }
    }
    
    private var updateUsersName: some View {
        Group {
            
            // Edit User
            VStack(alignment: .leading) {
                
                Text("Edit User")
                    .font(Font.custom("TitanOne", size: 30))
                
                // Edit User's name
                Text("Edit name")
                    .font(Font.custom("Quicksand-Bold", size: 20))
                
                Spacer()
                
                // TF
                TextField("Name", text: $updatedName)
                    .font(Font.custom("Quicksand-SemiBold", size: 20))
                    .foregroundColor(.primary)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(15)
                    .autocorrectionDisabled(true)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
//    SettingsView(viewModel: SettingsViewModel(authViewModel: AuthViewModel()))
    UpdatingView(settingsViewModel: SettingsViewModel(authViewModel: AuthViewModel(), firestoreManager: FirestoreManager()))
}
