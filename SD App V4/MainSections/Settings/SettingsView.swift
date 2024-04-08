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
    case dailyQuota

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
        case .dailyQuota:
            return ("Cat", "dailyQuota")
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
                            SettingsCard(iconImage: "person", name: "Name", info: userCatsViewModel.user.name, action: {
                                self.selectedOption = .usersName
                            })
                            
                            SettingsCard(iconImage: "envelope", name: "Email", info: userCatsViewModel.user.email, action: {
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
                            SettingsCard(iconImage: "cat", name: "Name", info: userCatsViewModel.cat.name, action: {
                                self.selectedOption = .catsName
                            })
                            SettingsCard(iconImage: "calendar", name: "Age", info: "\(userCatsViewModel.cat.age) years old", action: {
                                self.selectedOption = .age
                            })
                            SettingsCard(iconImage: "scalemass", name: "Weight", info: "\(userCatsViewModel.cat.weight ?? 0.0) lbs", action: {
                                self.selectedOption = .weight
                            })
                            SettingsCard(iconImage: "tag", name: "Collar Color", info: userCatsViewModel.cat.collarColor ?? "", action: {
                                self.selectedOption = .collarColor
                            })
                            SettingsCard(iconImage: "clock", name: "Daily Quota", info: "\(userCatsViewModel.cat.dailyQuota / 60) minutes", action: {
                                self.selectedOption = .dailyQuota
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
//struct UpdatingView: View {
//    
//    var option: UpdateOption
//    var updateAction: (_ updatedValue: String) -> Void
//    var dismissAction: () -> Void
//    
//    @State private var updatedValue = ""
//    @Environment(\.presentationMode) var presentationMode
//    
//    var body: some View {
//        ZStack {
//            Color(.systemGray5).ignoresSafeArea()
//            
//            VStack(alignment: .leading) {
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Image(systemName: "xmark")
//                            .font(.system(size: 25))
//                            .foregroundColor(Color.primary)
//                            .padding()
//                    }
//                }
//                
//                Group {
//                    Text("Update \(option.titleAndField.title)")
//                        .font(Font.custom("TitanOne", size: 30))
//                    
//                    Text("Update \(option.titleAndField.field)")
//                        .font(Font.custom("Quicksand-Bold", size: 20))
//                        .padding(.bottom, 30)
//                }
//                .padding(.horizontal, 20)
//                
//                switch option {
//                case .usersName, .email, .catsName:
//                    TextField("Enter updated \(option.titleAndField.field)", text: $updatedValue)
//                        .font(Font.custom("Quicksand-SemiBold", size: 20))
//                        .foregroundColor(.primary)
//                        .padding()
//                        .background(Color(.systemGray4))
//                        .cornerRadius(15)
//                        .padding()
//                        .autocorrectionDisabled(true)
//                case .age:
//                    Picker(selection: $updatedValue) {
//                        ForEach(0..<31) { number in
//                            Text("\(number)")
//                                .tag(number)
//                        }
//                    } label: {
//                        Text("Age")
//                    }
//                    .pickerStyle(WheelPickerStyle())
//                case .weight:
//                    TextField("Weight", text: $updatedValue)
//                        .keyboardType(.decimalPad)
//                        .generalTextfield()
//                case .collarColor:
//                    Group {
//                        Button(action: {
//                            updatedValue = "Red"
//                        }, label: {
//                            Text("Red")
//                                .redOutlineButton()
//                        })
//                        
//                        Button(action: {
//                            updatedValue = "Green"
//                        }, label: {
//                            Text("Green")
//                                .redOutlineButton()
//                        })
//                        
//                        Button(action: {
//                            updatedValue = "Blue"
//                        }, label: {
//                            Text("Blue")
//                                .redOutlineButton()
//                        })
//                    }
//                    .padding(.horizontal, 20)
//                case .dailyQuota:
//                    // Picker
//                    Picker(selection: $updatedValue) {
//                        ForEach(0..<60) { number in
//                            Text("\(number)")
//                                .tag(number)
//                        }
//                    } label: {
//                        Text("Daily Quota")
//                    }
//                    .pickerStyle(WheelPickerStyle())
//                    
//                }
//                
//                
//                Spacer()
//                
//                Button(action: {
//                    updateAction(updatedValue)
//                    dismissAction()
//                }, label: {
//                    Text("Update")
//                        .redButton()
//                        .padding(.horizontal, 20)
//                })
//            }
//        }
//    }
//}

struct UpdatingView: View {
    var option: UpdateOption
    var updateAction: (_ updatedValue: Any) -> Void
    var dismissAction: () -> Void

    @State private var textInput: String = ""
    @State private var pickerSelection: Int = 0

    @Environment(\.presentationMode) var presentationMode

    // Email validation method
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    var body: some View {
        ZStack {
            Color(.systemGray5).ignoresSafeArea()

            VStack(alignment: .leading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 25))
                        .foregroundColor(Color.primary)
                        .padding()
                }

                Group {
                    Text("Update \(option.titleAndField.title)")
                        .font(Font.custom("TitanOne", size: 30))

                    Text("Update \(option.titleAndField.field)")
                        .font(Font.custom("Quicksand-Bold", size: 20))
                        .padding(.bottom, 30)
                }
                .padding(.horizontal, 20)

                inputViewForOption(option)

                Spacer()

                Button(action: {
                    // Perform update action here
                    switch option {
                    case .email:
                        if isValidEmail(textInput) {
                            updateAction(textInput)
                        } else {
                            // Handle invalid email
                        }
                    case .weight:
                        if let number = Double(textInput) {
                            updateAction(number)
                        } else {
                            print("No good: \(textInput)")
                        }
                    case .age:
                        updateAction(pickerSelection)
                    case .dailyQuota:
                        // TODO: Might need to do some math
                        updateAction(pickerSelection * 60)
                    default:
                        updateAction(textInput)
                    }
                    dismissAction()
                }, label: {
                    Text("Update")
                        .redButton()
                        .padding(.horizontal, 20)
                })
            }
        }
    }

    // Define a method to return the appropriate input view based on the option
    @ViewBuilder
    private func inputViewForOption(_ option: UpdateOption) -> some View {
        switch option {
        // TODO: Email shouldn't autocap
        case .usersName, .email, .catsName:
            TextField("Enter updated \(option.titleAndField.field)", text: $textInput)
                .font(Font.custom("Quicksand-SemiBold", size: 20))
                .foregroundColor(.primary)
                .padding()
                .background(Color(.systemGray4))
                .cornerRadius(15)
                .padding(.horizontal, 20)
                .autocorrectionDisabled(true)
        case.collarColor:
            Group {
                Button(action: {
                    textInput = "Red"
                }, label: {
                    Text("Red")
                        .redOutlineButton()
                })

                Button(action: {
                    textInput = "Green"
                }, label: {
                    Text("Green")
                        .redOutlineButton()
                })

                Button(action: {
                    textInput = "Blue"
                }, label: {
                    Text("Blue")
                        .redOutlineButton()
                })
            }
            .padding(.horizontal, 20)
        case .weight:
            TextField("Enter updated \(option.titleAndField.field)", text: $textInput)
                .keyboardType(.decimalPad)
                .font(Font.custom("Quicksand-SemiBold", size: 20))
                .foregroundColor(.primary)
                .padding()
                .background(Color(.systemGray4))
                .cornerRadius(15)
                .padding(.horizontal, 20)
                .autocorrectionDisabled(true)
        case .age:
            Picker(selection: $pickerSelection) {
                ForEach(0..<31) { number in
                    Text("\(number)")
                        .tag(number)
                }
            } label: {
                Text("Age")
            }
            .pickerStyle(WheelPickerStyle())
        case .dailyQuota:
            // Picker
            Picker(selection: $pickerSelection) {
                ForEach(0..<60) { number in
                    Text("\(number)")
                        .tag(number)
                }
            } label: {
                Text("Daily Quota")
            }
            .pickerStyle(WheelPickerStyle())
        }
    }
}



//#Preview {
////    SettingsView(viewModel: SettingsViewModel(authViewModel: AuthViewModel()))
//    UpdatingView(settingsViewModel: SettingsViewModel(authViewModel: AuthViewModel(), firestoreManager: FirestoreManager()))
//}
