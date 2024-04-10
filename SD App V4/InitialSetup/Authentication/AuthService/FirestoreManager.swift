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
import FirebaseStorage

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
    
    func saveCatInfo(cat: Cat, id: String, completion: @escaping (Result<String, Error>) -> Void) {
        var catData: [String: Any] = [
            "name": cat.name,
            "breed": cat.breed,
            "sex": cat.sex ?? "unknown",
            "age": cat.age,
            "weight": cat.weight ?? 0.0,
            "collarColor": cat.collarColor ?? "unknown",
            "dailyQuota": cat.dailyQuota,
            "timePlayedToday": cat.timePlayedToday,
            "timeRemaining": cat.timeRemaining,
            "lastResetDate": cat.lastResetDate,
            "playtimeHistory": cat.playtimeHistory,
            "profilePicture": "https://firebasestorage.googleapis.com/v0/b/sd-app-v4.appspot.com/o/users%2FDEFAULTS%2FprofilePIcture.png?alt=media&token=75e2e7e5-9ee8-4fbf-aedc-3dad3131b155",
            "favoritePatterns": cat.favoritePatterns
        ]

        // Create a new cat document in Firestore
        let catDocRef = self.db.collection("users").document(id).collection("cats").document()
        catData["id"] = catDocRef.documentID
        
        // Save the cat data
        catDocRef.setData(catData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                // On success, return the cat's Firestore-generated ID
                print("Saved cat info with ID: \(catDocRef.documentID)")
                completion(.success(catDocRef.documentID))
            }
        }

    }
    
    func fetchUserData(id: String, completion: @escaping (Result<AppUser, Error>) -> Void) {
//        print("In fetchUserData the id is \(id)")
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

    func updateCatDataInFirestore(id: String, catID: String, updates: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        let catDocument = db.collection("users").document(id).collection("cats").document(catID)

        catDocument.updateData(updates) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error updating document: \(error)")
                    completion(.failure(error))
                } else {
                    print("Document successfully updated")
                    completion(.success(()))
                }
            }
        }
    }

    // Updates user's information in Firestore
    func updateUserInfo(id: String, updates: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        let userDocument = db.collection("users").document(id)

        userDocument.updateData(updates) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error updating user document: \(error)")
                    completion(.failure(error))
                } else {
                    print("User document successfully updated")
                    completion(.success(()))
                }
            }
        }
    }


    func fetchCatDataFromFirestore(userID: String, catID: String, field: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let catDocument = db.collection("users").document(userID).collection("cats").document(catID)

        catDocument.getDocument { (document, error) in
            if let error = error {
                print("Error fetching document: \(error)")
                completion(.failure(error))
            } else if let document = document, document.exists, let data = document.data() {
                if let fieldValue = data[field] as? String {
                    print("Successfully fetched \(field): \(fieldValue)")
                    completion(.success(fieldValue))
                } else {
                    // The document exists, but the specified field does not, or is not a String
                    let fieldError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Field '\(field)' not found or is not a String"])
                    completion(.failure(fieldError))
                }
            } else {
                let noDocumentError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No document found"])
                completion(.failure(noDocumentError))
            }
        }
    }
    
    func updatePlaytimeHistory(userId: String, catId: String, timePlayedToday: Int, completion: @escaping (Error?) -> Void) {
        let catDocument = db.collection("users").document(userId).collection("cats").document(catId)
        
        catDocument.getDocument { (document, error) in
            guard let document = document, let data = document.data(), error == nil else {
                completion(error ?? NSError(domain: "YourErrorDomain", code: -1, userInfo: nil))
                return
            }
            
            var playtimeHistory = data["playtimeHistory"] as? [Int] ?? []
            let lastUpdate = data["lastResetDate"] as? Timestamp ?? Timestamp(date: Date.distantPast)
            let lastUpdateDate = lastUpdate.dateValue()
            let calendar = Calendar.current

            // Check if the last update was today
            if calendar.isDateInToday(lastUpdateDate) {
                // It's the same day, so update the last entry
                if !playtimeHistory.isEmpty {
                    playtimeHistory[playtimeHistory.count - 1] = timePlayedToday
                } else {
                    // Should not happen, but adds safety
                    playtimeHistory.append(timePlayedToday)
                }
            } else {
                // It's a new day
                playtimeHistory.append(timePlayedToday)
                // Ensure the array does not exceed 7 elements
                if playtimeHistory.count > 7 {
                    playtimeHistory.removeFirst(playtimeHistory.count - 7)
                }
            }
            
            // Update the document in Firestore
            let updateData = [
                "playtimeHistory": playtimeHistory,
                "lastResetDate": Timestamp(date: Date()) // Update last update date
            ]
            catDocument.updateData(updateData) { error in
                completion(error)
            }
        }
    }


    
    // Upload profile picture do firebase storage
    func uploadImageToFirebase(_ imageData: Data, userID: String, catID: String, completion: @escaping (Result<URL, Error>) -> Void) {
        // Create a storage reference
        let storageRef = Storage.storage().reference().child("users/\(userID)/\(catID)/profilePicture.png")
        
        // Upload the image data
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Retrieve the download URL
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let downloadURL = url {
                    completion(.success(downloadURL))
                }
            }
        }
    }
}
