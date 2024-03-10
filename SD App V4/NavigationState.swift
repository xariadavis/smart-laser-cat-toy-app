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


enum AuthenticationNavigation {
    case login
    case register
    case forgotPassword
    case dashboard
}
