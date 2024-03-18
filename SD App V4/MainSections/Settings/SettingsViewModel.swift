//
//  SettingsViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    private let authViewModel: AuthViewModel
    
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }
    
    func logOut() {
        authViewModel.signOut()
    }
    
}

