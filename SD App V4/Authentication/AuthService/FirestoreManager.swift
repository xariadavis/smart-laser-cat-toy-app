//
//  FirestoreManager.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/16/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreManager {
    private let db = Firestore.firestore()
    
    func saveUserInfo(user: AppUser, uid: String, completion: @escaping (Error?) -> Void) {
        let userData: [String: Any] = [
            "id": uid,
            "name": user.name,
            "email": user.email
        ]
        
        db.collection("users").document(uid).setData(userData, completion: completion)
    }
    
    func fetchPatterns(completion: @escaping ([LaserPattern]) -> Void) {
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
    
    func saveCatInfo(cat: Cat, uid: String, completion: @escaping (Error?) -> Void) {
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
