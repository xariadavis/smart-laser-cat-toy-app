//
//  AuthViewModel.swift
//  SD App V3
//
//  Created by Xaria Davis on 3/1/24.
//

import Foundation
import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject {
    private let authService: AuthenticationService = FirebaseAuthService()
    @Published var isAuthenticated: Bool = false
    @Published var user: AuthDataResultModel?
    @Published var message: String?
    @Published var messageTitle: String?
    @Published var showAlert: Bool = false
    
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
            self.message = nil // Clear any previous error message
            self.messageTitle = nil
            
        } catch let error as NSError{
            print("Registration -- code: \(error.code), Description: \(error.localizedDescription)")
            let errorCode = error.code
            // Most common errors
            self.messageTitle = "Error"
            switch errorCode {
            case 17008:
                self.message = "The email address is invalid. Please try again."
            default:
                self.message = "An unknown error occurred: \(error.localizedDescription)"
            }
            
            self.showAlert = true
        }
    }

    
    func signIn(email: String, password: String) async {
        do {
            let authResult = try await authService.signIn(withEmail: email, password: password)
            self.user = authResult
            self.isAuthenticated = true
            self.message = nil // Clear any previous error message
            self.messageTitle = nil
            self.showAlert = false
        } catch let error as NSError {
            print("Error code: \(error.code), Description: \(error.localizedDescription)")
            let errorCode = error.code
            
            // Most common errors
            switch errorCode {
            case 17004:
                self.message = "Email or password is incorrect. Please try again"
            case 17008:
                self.message = "The email address is invalid. Please try again."
            default:
                self.message = "An unknown error occurred: \(error.localizedDescription)"
            }
            
            self.showAlert = true

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
    
    // Send reset password email
    func resetPassword(email: String) async {
        do {
            try await authService.resetPassword(email: email)
            
            self.messageTitle = "Success"
            self.message = "If the email is associated with an account, we'll send a reset password link to your email."
            self.showAlert = true
        } catch let error as NSError {
            
            self.messageTitle = "Error"
            self.message = error.localizedDescription
            self.showAlert = true
        }
    }
}
