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
            
            completion(.success(()))
            
        }
    }
    
    // Function to log in a user
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // If there's an error during the login process, pass it to the completion handler
                completion(.failure(error))
                return
            }
            
            // If login is successful, we don't need to do anything special here, so just return success
            completion(.success(()))
        }
    }
    
}
