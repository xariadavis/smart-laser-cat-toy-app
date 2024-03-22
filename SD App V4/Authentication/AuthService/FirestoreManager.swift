//
//  FirestoreManager.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/16/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreManager {
    
    // TODO: If time allows maybe separate this out?
    @ObservedObject var patternsManager = PatternsManager.shared  // TODO: Definitely fix this
    
    private let db = Firestore.firestore()
    
    func saveUserInfo(user: AppUser, id: String, completion: @escaping (Error?) -> Void) {
        let userData: [String: Any] = [
            "id": id,
            "name": user.name,
            "email": user.email
        ]
        
        self.db.collection("users").document(id).setData(userData, completion: completion)
    }
    
    func fetchPatterns2(completion: @escaping ([LaserPattern]) -> Void) {
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
    
    func saveCatInfo(cat: Cat, id: String, completion: @escaping (Error?) -> Void) {
        var catData: [String: Any] = [
            "name": cat.name,
            "breed": cat.breed,
            "sex": cat.sex ?? "unknown",
            "age": cat.age,
            "weight": cat.weight ?? 0.0,
            "color": cat.color ?? "unknown",
            "dailyQuota": cat.dailyQuota,
            "timePlayedToday": cat.timePlayedToday,
            "timeRemaining": cat.dailyQuota
        ]

        // Create a new cat document in Firestore
        let catDocRef = self.db.collection("users").document(id).collection("cats").document()
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
    
    func fetchUserData(id: String, completion: @escaping (Result<AppUser, Error>) -> Void) {
        print("In fetchUserData the id is \(id)")
        self.db.collection("users").document(id).getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists, let user = try? document.data(as: AppUser.self) {
                completion(.success(user))
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])))
            }
        }
    }

    
    func fetchCatForUser(id: String, completion: @escaping (Result<Cat, Error>) -> Void) {
        self.db.collection("users").document(id).collection("cats").limit(to: 1).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot, !snapshot.documents.isEmpty {
                if let cat = try? snapshot.documents.first?.data(as: Cat.self) {
                    completion(.success(cat))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode cat"])))
                }
            } else {
                completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No cat found for user"])))
            }
        }
    }

}
