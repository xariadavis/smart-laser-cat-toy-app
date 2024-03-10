//
//  ContentView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationState: NavigationState

    var body: some View {
        NavigationStack(path: $navigationState.path) {
            WelcomeView()
        }
    }
}
