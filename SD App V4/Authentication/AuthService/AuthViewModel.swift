//
//  AuthViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/11/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
 
class AuthViewModel {
    
    // private let db = Firestore.firestore()
    
    func register(user: AppUser, completion: @escaping (Result<String, Error>) -> Void) {
        // Use FirebaseAuth to create a new user
        Auth.auth().createUser(withEmail: user.email, password: user.password ?? "") { authResult, error in
            if let error = error {
                // If there's an error in the Firebase registration process, return the error
                completion(.failure(error))
                return
            }
            
            guard let id = authResult?.user.uid else {
                // If the id couldn't be retrieved, return a custom error
                let idError = NSError(domain: "UserRegistrationViewModel", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve id from Firebase Auth"])
                completion(.failure(idError))
                return
            }
            
            completion(.success(id))
            
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
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            
            // After signing out, the state listener set up in init will automatically
            // update isUserAuthenticated and currentUser to reflect the sign-out.
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func getCurrentUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }

}
