//
//  AuthManager.swift
//  SD App V3
//
//  Created by Xaria Davis on 3/1/24.
//

import Foundation
import FirebaseAuth


struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: FirebaseAuth.User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}


protocol AuthenticationService {
    func createUser(withEmail email: String, password: String) async throws -> AuthDataResultModel
    func signIn(withEmail email: String, password: String) async throws -> AuthDataResultModel
    func getAuthenticatedUser() throws -> AuthDataResultModel
    func signOut() throws
    func resetPassword(email: String) async throws
}

class FirebaseAuthService: AuthenticationService {

    func createUser(withEmail email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
        
    }
    
    func signIn(withEmail email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // Check if user is already logged in
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            print("Actually handle it but for now throw error")
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    // Send reset password email
    func resetPassword(email: String) async throws {
        print("In AuthernticatioNService: resetPassword")
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}
