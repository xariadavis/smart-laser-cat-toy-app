//
//  Onboarding.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/11/24.
//

import SwiftUI

struct OnboardingView: View {
    var catName: String
    
    @StateObject var viewModel: OnboardingViewModel
    @State private var newCat: Cat
    @FocusState private var isTextFieldFocused: Bool
    @State private var weightString: String = ""
    @State private var onboardingState: Int = 1
    @State private var alertTitle: String = ""
    @State private var showAlert: Bool = false
    let transition = AnyTransition(.blurReplace)
    
    
    init(catName: String, authViewModel: AuthViewModel) {
        self.catName = catName
        _newCat = State(initialValue: Cat(name: catName))
        _viewModel = StateObject(wrappedValue: OnboardingViewModel(authViewModel: authViewModel, firestoreManager: FirestoreManager()))
    }
        
    var body: some View {
        ZStack {
            
            Color(.systemGray5).ignoresSafeArea()
            
            ZStack {
                
                VStack(alignment: .leading) {
                    
                    switch onboardingState {
                    case 1:
                        getCatAge
                            .transition(transition.animation(.easeInOut(duration: 0.3)))
                    case 2:
                        getCatWeight
                            .transition(transition)
                    case 3:
                        getCatGender
                            .transition(transition)
                    case 4:
                        getCatBreed
                            .transition(transition)
                    case 5:
                        getCatDailyQuota
                            .transition(transition)
                    default:
                        WelcomeView()
                    }
                    
                    bottomButton
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
            }
            .alert(isPresented: $showAlert, content: {
                return Alert(title: Text(alertTitle ))
            })
        }
    }
    
    private var getCatAge: some View {
        Group {
            Text("How old is \(newCat.name)?")
                .font(Font.custom("Quicksand-Bold", size: 30))
            
            // Picker
            Picker(selection: $newCat.age) {
                ForEach(0..<31) { number in
                    Text("\(number)")
                        .tag(number)
                }
            } label: {
                Text("Age")
            }
            .pickerStyle(WheelPickerStyle())
            
            Spacer()
            
        }
    }
    
    private var getCatWeight: some View {
        Group {
            Text("How much does \(newCat.name) weigh?")
                .font(Font.custom("Quicksand-Bold", size: 30))
            
            HStack {
                TextField("Weight", text: $weightString)
                    .keyboardType(.decimalPad)
                    .generalTextfield()
                    .focused($isTextFieldFocused)
                    .onChange(of: weightString) { newValue in
                        self.newCat.weight = Double(newValue)
                    }
                
                Text("lbs")
                    .font(Font.custom("Quicksand-Semibold", size: 20))
                    .foregroundColor(.secondary).opacity(0.5)
                    .padding()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isTextFieldFocused = false
                    }
                }
            }

            Spacer()
        }
    }
    
    private var getCatGender: some View {
        Group {
            Text("What's \(String(describing: newCat.name))'s gender?")
                .font(Font.custom("Quicksand-Bold", size: 30))
            
            Group {
                Button(action: {
                    self.newCat.sex = "Male"
                }, label: {
                    Text("Male")
                        .redOutlineButton()
                })
                
                Button(action: {
                    self.newCat.sex = "Female"
                }, label: {
                    Text("Female")
                        .redOutlineButton()
                })
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
    }
    
    private var getCatBreed: some View {
        Group {
            Text("What breed is \(newCat.name)?")
                .font(Font.custom("Quicksand-Bold", size: 30))
            
            Picker("Select a Breed", selection: $newCat.breed) {
                ForEach(catBreeds, id: \.self) { breed in
                    Text(breed).tag(breed)
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Spacer()
            
        }
    }
    
    // Not taken yet
    private var getCatDailyQuota: some View {
        Group {
            Text("How long should \(newCat.name) play daily?")
                .font(Font.custom("Quicksand-Bold", size: 30))
            
            // Picker
            Picker(selection: $newCat.dailyQuota) {
                ForEach(0..<60) { number in
                    Text("\(number)")
                        .tag(number)
                }
            } label: {
                Text("Daily Quota")
            }
            .pickerStyle(WheelPickerStyle())
            Spacer()
            
        }
    }
    
    private var bottomButton: some View {
        
        Button(action: {
            handleButtonPress()
        }, label: {
            Text(onboardingState == 4 ? "Finish" : "Next")
                .redButton()
                .animation(nil)
        })
        
    }
}

// MARK: Utils

extension OnboardingView {
    
    func handleButtonPress() {
        
        switch onboardingState {
        case 2:
            guard let weight = newCat.weight, weight > 0 else {
                showAlert(title: "Please enter \(newCat.name)'s weight!")
                return
            }
        case 3:
            guard let gender = newCat.sex, gender != "" else {
                showAlert(title: "Please enter \(newCat.name)'s gender!")
                return
            }
        default:
            break
        }
        
        if onboardingState == 5 {
            print("\(newCat.name) + \(newCat.age) + \(newCat.weight) + \(newCat.sex) + \(newCat.breed)")
            viewModel.updateCatInfo(cat: newCat)
        } else {
            withAnimation(.spring()) {
                onboardingState += 1
            }
        }
        
    }
    
    func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
    
}

let catBreeds = [
    "Abyssinian",
    "American Bobtail",
    "American Curl",
    "American Shorthair",
    "American Wirehair",
    "Balinese",
    "Bengal",
    "Birman",
    "Bombay",
    "British Shorthair",
    "Burmese",
    "Burmilla",
    "Chartreux",
    "Cornish Rex",
    "Devon Rex",
    "Domestic Short Hair",
    "Domestic Medium Hair",
    "Domestic Long Hair",
    "Egyptian Mau",
    "Exotic Shorthair",
    "Himalayan",
    "Japanese Bobtail",
    "Khao Manee",
    "Korat",
    "LaPerm",
    "Maine Coon",
    "Manx",
    "Munchkin",
    "Norwegian Forest Cat",
    "Ocicat",
    "Oriental",
    "Persian",
    "Peterbald",
    "Pixie-bob",
    "Ragamuffin",
    "Ragdoll",
    "Russian Blue",
    "Scottish Fold",
    "Selkirk Rex",
    "Siamese",
    "Siberian",
    "Singapura",
    "Somali",
    "Sphynx",
    "Tonkinese",
    "Toyger",
    "Turkish Angora",
    "Turkish Van"
]


//#Preview {
//    OnboardingView(catName: "Walty")
//}
