//
//  GlowingView.swift
//  Senior Design V1
//
//  Created by Xaria Davis on 1/26/24.
//

import SwiftUI

struct Glow: ViewModifier {
    func body(content: Content) -> some View {
        ZStack{
            content
                .blur(radius: 25)
            content
        }
    }
}

extension View {
    func glow() -> some View {
        modifier(Glow())
    }
}
