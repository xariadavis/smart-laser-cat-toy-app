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
    
//    func updateCatInfo(cat: Cat) {
//        firestoreManager.saveCatInfo(cat: cat, id: authViewModel.getCurrentUserID() ?? "Current UserID not found") { error in
//            if let error = error {
//                // TODO: Handle the error
//                print("Error updating cat info: \(error.localizedDescription)")
//            } else {
//                print("Cat info successfully saved.")
//            }
//        }
//        
//    }
    
    func updateCatInfo(cat: Cat, completion: @escaping (Bool) -> Void) {
        firestoreManager.saveCatInfo(cat: cat, id: authViewModel.getCurrentUserID() ?? "Current UserID not found") { error in
            if let error = error {
//                print("Error updating cat info: \(error.localizedDescription)")
                completion(false) // Call completion with false to indicate failure
            } else {
//                print("Cat info successfully saved.")
                completion(true) // Call completion with true to indicate success
            }
        }
    }
    
    func getUserID() -> String {
        return authViewModel.getCurrentUserID() ?? ""
    }

}
