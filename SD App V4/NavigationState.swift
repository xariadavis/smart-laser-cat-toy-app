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
}


enum AuthenticationNavigation: Hashable {
    case login
    case register
    case forgotPassword
    case onboarding(catName: String)

}

enum MainNavigation: Int, Hashable, CaseIterable {
    case dashboard = 0
    case patternsList = 1
    case profile = 2
    case settings = 3
    case root
}

enum LoadingNavigation: Hashable {
    case loadingFromOnboarding
}
