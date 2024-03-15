//
//  OnboardingViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/14/24.
//

import Foundation

@MainActor
class OnboardingViewModel: ObservableObject {
    
    private let authViewModel: AuthViewModel
    
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }
    
    func updateCatInfo(cat: Cat) {
        authViewModel.saveCatInfo(cat: cat) { error in
            if let error = error {
                // TODO: Handle the error
                print("Error updating cat info: \(error.localizedDescription)")
            } else {
                print("Cat info successfully saved.")
            }
        }
    }
}
