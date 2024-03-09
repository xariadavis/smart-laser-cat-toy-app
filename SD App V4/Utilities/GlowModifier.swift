//
//  GlowModifier.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/9/24.
//

import Foundation
import SwiftUI

struct Glow: ViewModifier {
    func body(content: Content) -> some View {
        ZStack{
            content
                .blur(radius: 3)
            content
        }
    }
}

extension View {
    func glow() -> some View {
        modifier(Glow())
    }
}
