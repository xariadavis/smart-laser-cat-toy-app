//
//  UserManager.swift
//  SD App V3
//
//  Created by Xaria Davis on 3/6/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class UserManager: UserManagerProtocol, ObservableObject {
    
    private let usersCollection = Firestore.firestore().collection("users")
    
    init() {}
    
    func userDocument(userID: String) -> DocumentReference {
        return usersCollection.document(userID)
    }
    
    func createNewUser(user: User) async throws {
        try userDocument(userID: user.id).setData(from: user, merge: false)
    }
    
    func addCat(userID: String, cat: Cat) async throws -> String {
        let catData = try Firestore.Encoder().encode(cat)
        let newCat = try await usersCollection.document(userID).collection("cats").addDocument(data: catData)
        
        return newCat.documentID
    }
    
    // Fetch User from Firestore and cache it
    func fetchAndCacheUser(withId id: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        print("UserManager: fetchAndCacheUser() called")
        
        // First, attempt to load the user from UserDefaults
        if let cachedUser = loadUser(withId: id) {
            completion(.success(cachedUser))
            print("UserManager: first load successful -- \(cachedUser.email)")
            return
        }
        
        // If not cached, fetch the user from Firestore
        usersCollection.document(id).getDocument { documentSnapshot, error in
            guard let documentSnapshot = documentSnapshot, documentSnapshot.exists else {
                completion(.failure(error ?? NSError(domain: "UserService", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                return
            }
            
            do {
                let user = try documentSnapshot.data(as: User.self)
                // Cache the fetched user
                self.saveUser(user: user)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    // Saving User to UserDefaults
    private func saveUser(user: User) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(user)
            UserDefaults.standard.set(data, forKey: "cachedUser")
        } catch {
            print("Failed to encode user: \(error.localizedDescription)")
        }
    }
    
    // Loading User from UserDefaults
    private func loadUser(withId id: String) -> User? {
        if let userData = UserDefaults.standard.data(forKey: "cachedUser") {
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: userData)
                return user
            } catch {
                print("Failed to decode user: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    func updateUser(_ user: User) {
        // Update in Firestore
        let document = usersCollection.document(user.id)
        do {
            try document.setData(from: user)
            // Update cache after successful Firestore update
            saveUser(user: user)
        } catch {
            print("Error updating user: \(error.localizedDescription)")
        }
    }


    
}
