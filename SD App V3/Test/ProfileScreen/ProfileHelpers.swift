//
//  ProfileHelpers.swift
//  Example
//
//  Created by Alisa Mylnikova on 11/11/2021.
//  Copyright © 2021 Exyte. All rights reserved.
//

import SwiftUI

struct HireButtonStyle: ButtonStyle {

    var foreground = Color.white

    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray)
            .overlay(configuration.label.foregroundColor(foreground))
    }
}
//
//extension View {
//
//    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
//        clipShape( RoundedCorner(radius: radius, corners: corners) )
//    }
//}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
