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
    
    private let db = Firestore.firestore()
    
    func register(user: User, completion: @escaping (Result<String, Error>) -> Void) {
        // Use FirebaseAuth to create a new user
        Auth.auth().createUser(withEmail: user.email, password: user.password ?? "") { authResult, error in
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
        let userData: [String: Any] = [
            "id": uid,
            "name": user.name,
            "email": user.email
        ]
        
        // Save user information to Firestore
        self.db.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                completion(error)
                return
            }
        }
    }
    
    func fetchPatterns(completion: @escaping ([LaserPattern]) -> Void) {
        let db = Firestore.firestore()
        db.collection("patterns").getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                completion([]) // Return an empty array if there's an error
                return
            }
            
            let patterns = documents.compactMap { queryDocumentSnapshot -> LaserPattern? in
                try? queryDocumentSnapshot.data(as: LaserPattern.self)
            }
            print("Patterns fetched!")
            completion(patterns) // Return the fetched patterns
        }
    }
    
    func getCurrentUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }

    func saveCatInfo(cat: Cat, completion: @escaping (Error?) -> Void) {
        let uid: String = getCurrentUserID() ?? "could not get uid"
        
        var catData: [String: Any] = [
            "name": cat.name,
            "breed": cat.breed,
            "sex": cat.sex ?? "unknown",
            "age": cat.age,
            "weight": cat.weight ?? 0.0,
            "color": cat.color ?? "unknown"
        ]

        // Create a new cat document in Firestore
        let catDocRef = self.db.collection("users").document(uid).collection("cats").document()
        catData["id"] = catDocRef.documentID
        
        // Save the cat data
        catDocRef.setData(catData) { error in
            if let error = error {
                completion(error)
            } else {
                // Optionally, handle the cat's Firestore-generated ID here if necessary
                print("Saved cat info with ID: \(catDocRef.documentID)")
                completion(nil)
            }
        }
    }

}
