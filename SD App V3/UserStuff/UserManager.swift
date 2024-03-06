//
//  UserManager.swift
//  SD App V3
//
//  Created by Xaria Davis on 3/6/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserManager: UserManagerProtocol {
    
    private let userCollection = Firestore.firestore().collection("users")
    
    func userDocument(userID: String) -> DocumentReference {
        return userCollection.document(userID)
    }
    
    func createNewUser(user: User) async throws {
        try userDocument(userID: user.id).setData(from: user, merge: false)
    }
    
    func addCat(userID: String, cat: Cat) async throws -> String {
        let catData = try Firestore.Encoder().encode(cat)
        let newCat = try await userCollection.document(userID).collection("cats").addDocument(data: catData)
        
        return newCat.documentID
    }
    
}
