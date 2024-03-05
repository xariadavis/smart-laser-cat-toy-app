//
//  FirebaseAuthService.swift
//  SD App V3
//
//  Created by Xaria Davis on 3/4/24.
//

import Foundation
import FirebaseAuth

class FirebaseAuthService: AuthenticationService {
    func getAuthenticatedUser() -> AuthDataResultModel? {
        guard let user = Auth.auth().currentUser else {
            print("FirebaseAuthService: No user is signed in")
            return nil // No user is signed in
        }
        return AuthDataResultModel(user: user)
    }

    func createUser(withEmail email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
        
    }
    
    func signIn(withEmail email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    // Send reset password email
    func resetPassword(email: String) async throws {
        print("In FirebaseAuthService resetPassword")
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}
