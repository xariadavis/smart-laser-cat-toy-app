//
//  MainPalette.swift
//  SD App V2
//
//  Created by Xaria Davis on 1/29/24.
//

import SwiftUI

extension Color {
    public static let darkBlue = Color(red: 10/255, green: 47/255, blue: 89/255)
    public static let midBlue = Color(red: 22/255, green: 110/255, blue: 229/255)
    public static let lightBlue = Color(red: 103/255, green: 171/255, blue: 241/255)
    public static let myOrange = Color(red: 243/255, green: 139/255, blue: 30/255)
    public static let myRed = Color(red: 240/255, green: 5/255, blue: 15/255)
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
    
    static var exampleGrey = Color(hex: "0C0C0C")
    static var exampleLightGrey = Color(hex: "#B1B1B1")
    static var examplePurple = Color(hex: "7D26FE")
}
