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
    
    func register(user: User, completion: @escaping (Result<String, Error>) -> Void) {
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
            
            completion(.success(uid))
            
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
    
    func saveUserInfo(user: User, uid: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let userData: [String: Any] = [
            "id": uid,
            "name": user.name,
            "email": user.email
        ]
        
        // Save user information to Firestore
        db.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                completion(error)
                return
            }
            
            // User has cat
            if let cat = user.cat {
                var catData: [String: Any] = [
                    "name": cat.name
                ]
                
                // Initially add the cat document to Firestore without the ID
                let catDocRef = db.collection("users").document(uid).collection("cats").document()
                
                // Now, include the generated ID in catData
                catData["id"] = catDocRef.documentID
                
                // Finally, set the cat document with all data, including the ID
                catDocRef.setData(catData) { error in
                    completion(error)
                }
                
            } else {
                // No cat data to save, so complete without error
                completion(nil)
            }
        }
    }

    
}
