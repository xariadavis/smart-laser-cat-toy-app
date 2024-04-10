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
                                viewModel.selectOption(.usersName)
                            })
                            
                            SettingsCard(iconImage: "envelope", name: "Email", info: userCatsViewModel.user.email, action: {
                                viewModel.selectOption(.email)
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
                                viewModel.selectOption(.catsName)
                            })
                            var age = userCatsViewModel.cat.age
                            SettingsCard(iconImage: "calendar", name: "Age", info: "\(age) \(age == 1 ? "year" : "years") old", action: {
                                viewModel.selectOption(.age)
                            })
                            SettingsCard(iconImage: "scalemass", name: "Weight", info: "\(userCatsViewModel.cat.weight ?? 0.0) lbs", action: {
                                viewModel.selectOption(.weight)
                            })
                            SettingsCard(iconImage: "tag", name: "Collar Color", info: userCatsViewModel.cat.collarColor ?? "", action: {
                                viewModel.selectOption(.collarColor)
                            })
                            SettingsCard(iconImage: "clock", name: "Daily Quota", info: "\(userCatsViewModel.cat.dailyQuota / 60) minutes", action: {
                                viewModel.selectOption(.dailyQuota)
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
        .fullScreenCover(item: $viewModel.selectedOption) { option in
            UpdatingView(option: option, viewModel: viewModel, dismissAction: {
                viewModel.selectedOption = nil
            })
        }

    }
}

struct UpdatingView: View {
    var option: UpdateOption
        @ObservedObject var viewModel: SettingsViewModel
        @ObservedObject var userCatsViewModel = UserCatsViewModel.shared
    
        var dismissAction: () -> Void
        
        @State private var textInput: String = ""
        @State private var pickerSelection: Int = 0

        @State private var showAlert = false // Step 1
        

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
                        dismissAction()
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
                    }.padding(.horizontal, 20)

                    inputViewForOption(option)

                    Spacer()

                    Button(action: {
                        if option == .email && !isValidEmail(textInput) {
                            showAlert = true
                            return
                        }
                        
                        viewModel.handleUpdate(option: option, textInput: textInput, pickerSelection: pickerSelection)
                        presentationMode.wrappedValue.dismiss()
                        dismissAction()
                    }) {
                        Text("Update")
                            .redButton()
                            .padding(.horizontal, 20)
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Invalid Email"),
                    message: Text("Please enter a valid email address."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }


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
                .autocapitalization(option == .email ? .none : .words)
                .onAppear {
                    switch option {
                    case .usersName:
                        // Fetch and set the user's name
                        self.textInput = userCatsViewModel.user.name
                    case .email:
                        // Fetch and set the email
                        self.textInput = userCatsViewModel.user.email
                    case .catsName:
                        // Fetch and set the cat's name
                        self.textInput = userCatsViewModel.cat.name
                    default:
                        self.textInput = ""
                    }
                }
        case .collarColor:
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
            .onAppear {
                // TODO: Need to select but no indication yet
                self.textInput = userCatsViewModel.cat.collarColor ?? ""
            }
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
                .onAppear {
                    self.textInput = String(userCatsViewModel.cat.weight ?? 0.0)
                }
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
            .onAppear {
                self.pickerSelection = userCatsViewModel.cat.age
            }
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
            .onAppear {
                self.pickerSelection = userCatsViewModel.cat.dailyQuota / 60
            }
        }
    }
}
