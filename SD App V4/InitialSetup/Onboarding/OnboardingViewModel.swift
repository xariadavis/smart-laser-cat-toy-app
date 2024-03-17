//
//  OnboardingViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/14/24.
//

import Foundation

@MainActor
class OnboardingViewModel: ObservableObject {
    
    private var authViewModel: AuthViewModel
    private var firestoreManager: FirestoreManager
    
    init(authViewModel: AuthViewModel, firestoreManager: FirestoreManager) {
        self.authViewModel = authViewModel
        self.firestoreManager = firestoreManager
    }
    
    func updateCatInfo(cat: Cat) {
        firestoreManager.saveCatInfo(cat: cat, uid: authViewModel.getCurrentUserID() ?? "Current UserID not found") { error in
            if let error = error {
                // TODO: Handle the error
                print("Error updating cat info: \(error.localizedDescription)")
            } else {
                print("Cat info successfully saved.")
            }
        }
    }
}
