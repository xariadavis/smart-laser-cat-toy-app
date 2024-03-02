//
//  AuthViewModel.swift
//  SD App V3
//
//  Created by Xaria Davis on 3/1/24.
//

import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    private let authService: AuthenticationService = FirebaseAuthService()
    @Published var isAuthenticated: Bool = false
    @Published var user: AuthDataResultModel?
    
    init() {
        // Check if a user is already logged in when the app starts
        do {
            let user = try authService.getAuthenticatedUser()
            self.user = user
            self.isAuthenticated = true
        } catch {
            self.isAuthenticated = false
        }
    }
    
    func signUp(email: String, password: String) async {
        do {
            let authResult = try await authService.createUser(withEmail: email, password: password)
            self.user = authResult
            self.isAuthenticated = true
        } catch {
            // Handle errors, possibly by updating another @Published property to show error messages
            print("Sign up failed: \(error.localizedDescription)")
        }
    }
    
    func signIn(email: String, password: String) async {
        do {
            let authResult = try await authService.signIn(withEmail: email, password: password)
            self.user = authResult
            self.isAuthenticated = true
        } catch {
            // Handle errors, possibly by updating another @Published property to show error messages
            print("Sign in failed: \(error.localizedDescription)")
        }
    }
    
    // TODO: Handle error
    func signOut() {
        do {
            try authService.signOut()
            self.isAuthenticated = false
            self.user = nil
            // Perform any additional cleanup if necessary
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            // Handle errors, possibly by updating another @Published property to show error messages
        }
    }
}
