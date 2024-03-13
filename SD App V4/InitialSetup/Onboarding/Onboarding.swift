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
                
                Text("What's \(String(describing: sharedInfo.catName)) gender?")
                    .font(Font.custom("Quicksand-Bold", size: 30))
                
                Spacer()
                
                
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
}

#Preview {
    Onboarding()
}
