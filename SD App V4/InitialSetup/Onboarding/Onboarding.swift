//
//  Onboarding.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/11/24.
//

import SwiftUI

struct Onboarding: View {
    
    @ObservedObject private var sharedInfo = SharedRegistrationInfo.shared
    @FocusState private var isTextFieldFocused: Bool
    @State private var newCat: Cat = Cat(name: "your cat?")
    @State private var weightString: String = ""
    
        
    var body: some View {
        ZStack {
            
            Color(.systemGray5).ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
        }
    }
    
    private var getCatAge: some View {
        Group {
            Text("How old is \(String(describing: sharedInfo.catName))")
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
            
            Button(action: {
                print("Age selected is: \(self.newCat.age)")
            }, label: {
                Text("Next")
                    .redButton()
            })
        }
    }
    
    private var getCatWeight: some View {
        Group {
            Text("How much does \(sharedInfo.catName) weigh?")
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
            
            Button(action: {
                print("The new cat weight is: \(self.newCat.weight)")
            }, label: {
                Text("Next")
                    .redButton()
            })
        }
    }
    
    private var getCatGender: some View {
        Group {
            Text("What's \(String(describing: sharedInfo.catName))'s gender?")
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
            
            
            Button(action: {
                print("The cat's gender is: \(String(describing: self.newCat.sex))")
            }, label: {
                Text("Next")
                    .redButton()
                    .padding(.horizontal, 20)
            })
        }
    }
    
    private var getCatBreed: some View {
        Group {
            Text("What breed is \(sharedInfo.catName)?")
                .font(Font.custom("Quicksand-Bold", size: 30))
            
            Picker("Select a Breed", selection: $newCat.breed) {
                ForEach(catBreeds, id: \.self) { breed in
                    Text(breed).tag(breed)
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Spacer()
            
            Button(action: {
                print("The cat breed is: \(newCat.breed)")
            }, label: {
                Text("Next")
                    .redButton()
                    .padding(.horizontal, 20)
            })
        }
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


#Preview {
    Onboarding()
}
