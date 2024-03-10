//
//  NavigationState.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/9/24.
//

import Foundation
import SwiftUI

class NavigationState: ObservableObject {
    @Published var path = NavigationPath()
    // @Published var currentTab: Tab = .dashboard
}


enum AuthenticationNavigation: Hashable {
    case login
    case register
    case forgotPassword
    case dashboard
}

enum MainNavigation: Hashable {
    case dashboard
    case patternsList
    case profile
    case settings
}
