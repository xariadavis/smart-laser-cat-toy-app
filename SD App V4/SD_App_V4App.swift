//
//  SD_App_V4App.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI
import UIKit

@main
struct SD_App_V4App: App {
    @StateObject private var navigationState = NavigationState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationState)
        }
    }
}
