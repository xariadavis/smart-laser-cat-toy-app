//
//  TextMods.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/12/24.
//

import Foundation
import SwiftUI

extension View {
    
    func redButton() -> some View {
        modifier(RedButton())
    }
    
    func redOutlineButton() -> some View {
        modifier(RedOutlineButton())
    }
}

struct RedButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Quicksand-SemiBold", size: 20))
            .frame(maxWidth: .infinity)
            .padding(15)
            .foregroundColor(Color.primary)
            .background(Color.red.opacity(0.9))
            .cornerRadius(40)
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
    }
}

struct RedOutlineButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Quicksand-SemiBold", size: 20))
            .foregroundColor(Color.primary)
            .frame(maxWidth: .infinity)
            .padding(15)
            .cornerRadius(30)
            .contentShape(Rectangle())
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.red.opacity(0.9), lineWidth: 2)
                    // Apply glow effect
                    .shadow(color: Color.red.opacity(0.3), radius: 10, x: 0, y: 0)
                    .shadow(color: Color.red.opacity(0.3), radius: 20, x: 0, y: 0)
                    .shadow(color: Color.red.opacity(0.3), radius: 30, x: 0, y: 0)
                    .shadow(color: Color.red.opacity(0.3), radius: 40, x: 0, y: 0)
            )
            .padding(.horizontal, 40)
    }
}
