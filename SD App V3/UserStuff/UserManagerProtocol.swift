//
//  UserManagerProtocol.swift
//  SD App V3
//
//  Created by Xaria Davis on 3/6/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol UserManagerProtocol {
    func userDocument(userID: String) -> DocumentReference
    func createNewUser(user: User) async throws
    func addCat(userID: String, cat: Cat) async throws -> String
}

