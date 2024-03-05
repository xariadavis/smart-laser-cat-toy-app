//
//  AuthManager.swift
//  SD App V3
//
//  Created by Xaria Davis on 3/1/24.
//

import Foundation

protocol AuthenticationService {
    func createUser(withEmail email: String, password: String) async throws -> AuthDataResultModel
    func signIn(withEmail email: String, password: String) async throws -> AuthDataResultModel
    func getAuthenticatedUser() -> AuthDataResultModel?
    func signOut() throws
    func resetPassword(email: String) async throws
}
