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

    
    // Assuming authViewModel.getCurrentUserID() returns an optional String
    func updateCatInfo(cat: Cat, completion: @escaping (Result<String, Error>) -> Void) {
        guard let userId = authViewModel.getCurrentUserID() else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Current UserID not found"])))
            return
        }
        
        firestoreManager.saveCatInfo(cat: cat, id: userId) { result in
            switch result {
            case .success(let catId):
                print("Successfully saved cat with ID: \(catId)")
                // Pass the success result up the chain
                completion(.success(catId))
                
            case .failure(let error):
                print("Error saving cat: \(error.localizedDescription)")
                // Pass the error result up the chain
                completion(.failure(error))
            }
        }
    }

    
    func getUserID() -> String {
        return authViewModel.getCurrentUserID() ?? ""
    }

}
