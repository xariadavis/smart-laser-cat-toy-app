//
//  SettingsView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI
import Foundation

enum UpdateOption: Identifiable {
    case usersName
    case email
    case catsName
    case age
    case weight
    case collarColor

    var id: Self { self }
    
    var titleAndField: (title: String, field: String) {
        switch self {
        case .usersName:
            return ("User", "name")
        case .email:
            return ("User", "email")
        case .catsName:
            return ("Cat", "name")
        case .age:
            return ("Cat", "age")
        case .weight:
            return ("Cat", "weight")
        case .collarColor:
            return ("Cat", "collarColor")
        }
    }
}


struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel // Create an instance of BluetoothViewModel
    @ObservedObject var userCatsViewModel = UserCatsViewModel.shared
    
    @State private var selectedOption: UpdateOption?
    @State private var isUpdating: Bool = false
    
    @State var updatedValue: String = ""
    @State var title: String = ""
    @State var field: String = ""
    
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
                            SettingsCard(iconImage: "person", name: "Name", action: {
                                self.selectedOption = .usersName
                            })
                            
                            SettingsCard(iconImage: "envelope", name: "Email", action: {
                                self.selectedOption = .email
                            })
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
                            SettingsCard(iconImage: "cat", name: "Name", action: {
                                self.selectedOption = .catsName
                            })
                            SettingsCard(iconImage: "calendar", name: "Age", action: {
                                self.selectedOption = .age
                            })
                            SettingsCard(iconImage: "scalemass", name: "Weight", action: {
                                self.selectedOption = .weight
                            })
                            SettingsCard(iconImage: "tag", name: "Collar Color", action: {
                                self.selectedOption = .collarColor
                            })
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
        .fullScreenCover(item: $selectedOption) { option in
            UpdatingView(option: option, updateAction: { updatedValue in
                
                // Handle update logic here
                if option.titleAndField.title == "User" {
                    viewModel.updateUserField(id: userCatsViewModel.user.id, updates: [option.titleAndField.field : updatedValue])
                } else if option.titleAndField.title == "Cat" {
                    viewModel.updateCatField(id: userCatsViewModel.user.id, catID: userCatsViewModel.cat.id ?? "", updates: [option.titleAndField.field : updatedValue])
                }
                
                sessionManager.refreshCurrentUser()
                
            }, dismissAction: {
                self.selectedOption = nil
                self.updatedValue = ""
            })
        }

    }
}

// TODO: Implement selective refreshing
struct UpdatingView: View {
    
    var option: UpdateOption
    var updateAction: (_ updatedValue: String) -> Void
    var dismissAction: () -> Void
    
    @State private var updatedValue = ""
    @Environment(\.presentationMode) var presentationMode
    
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
                
                Text("Edit \(option.titleAndField.title)")
                    .font(Font.custom("TitanOne", size: 30))
                
                Text("Edit \(option.titleAndField.field)")
                    .font(Font.custom("Quicksand-Bold", size: 20))
                    .padding(.bottom, 30)
                
                TextField("Enter value", text: $updatedValue)
                    .font(Font.custom("Quicksand-SemiBold", size: 20))
                    .foregroundColor(.primary)
                    .padding()
                    .background(Color(.systemGray4))
                    .cornerRadius(15)
                    .padding()
                    .autocorrectionDisabled(true)
                
                Spacer()
                
                Button(action: {
                    updateAction(updatedValue)
                    dismissAction()
                }, label: {
                    Text("Update")
                        .redButton()
                        .padding(.horizontal, 20)
                })
                
                Spacer()
            }
        }
    }
}


//#Preview {
////    SettingsView(viewModel: SettingsViewModel(authViewModel: AuthViewModel()))
//    UpdatingView(settingsViewModel: SettingsViewModel(authViewModel: AuthViewModel(), firestoreManager: FirestoreManager()))
//}
