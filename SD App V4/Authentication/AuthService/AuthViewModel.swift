//
//  AuthViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/11/24.
//

import Foundation
import FirebaseAuth

class AuthViewModel {
    
    func register(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        // Use FirebaseAuth to create a new user
        Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
            if let error = error {
                // If there's an error in the Firebase registration process, return the error
                completion(.failure(error))
                return
            }
            
            guard let uid = authResult?.user.uid else {
                // If the UID couldn't be retrieved, return a custom error
                let uidError = NSError(domain: "UserRegistrationViewModel", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve UID from Firebase Auth"])
                completion(.failure(uidError))
                return
            }
            
        }
    }
    
}
