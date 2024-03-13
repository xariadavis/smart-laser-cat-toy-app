//
// Created for NumericTextFields
// by Stewart Lynch on 2022-12-18
// Using Swift 5.0
//
// Follow me om Mastodon: @StewartLynch@iosDev.space
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI
import Combine

extension View {
    
    func numbersOnly(_ text: Binding<String>, includeDecimal: Bool = false) -> some View {
        self.modifier(NumbersOnlyViewModifier(text: text, includeDecimal: includeDecimal))
    }
    
    func generalTextfield() -> some View {
        self.modifier(GeneralTextFieldViewModifier())
    }
}

struct NumbersOnlyViewModifier: ViewModifier {
    
    @Binding var text: String
    var includeDecimal: Bool
    
    func body(content: Content) -> some View {
        content
            .keyboardType(includeDecimal ? .decimalPad : .numberPad)
            .onReceive(Just(text)) { newValue in
                var numbers = "0123456789"
                let decimalSeparator: String = Locale.current.decimalSeparator ?? "."
                if includeDecimal {
                    numbers += decimalSeparator
                }
                if newValue.components(separatedBy: decimalSeparator).count-1 > 1 {
                    let filtered = newValue
                    self.text = String(filtered.dropLast())
                } else {
                    let filtered = newValue.filter { numbers.contains($0)}
                    if filtered != newValue {
                        self.text = filtered
                    }
                }
            }
    }
}

struct GeneralTextFieldViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Quicksand-SemiBold", size: 20))
            .foregroundColor(.primary)
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(15)
            .autocapitalization(.none)
            .autocorrectionDisabled(true)
    }
}
