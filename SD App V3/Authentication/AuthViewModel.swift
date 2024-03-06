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
    
    private let authService: AuthenticationService
    private let userService: UserManagerProtocol
    
    @Published var isAuthenticated: Bool = false
    @Published var user: AuthDataResultModel?
    @Published var message: String?
    @Published var showAlert: Bool = false
    @Published var isSuccess: Bool = false
    
    init(authService: AuthenticationService, userService: UserManagerProtocol) {
        self.authService = authService
        self.userService = userService
        
        // Initial check for authentication state
        self.checkAuthentication()
    }
    
    func checkAuthentication() {
        // Check if a user is already logged in when the app starts
        if let user = authService.getAuthenticatedUser() {
            self.user = user
            self.isAuthenticated = true
        } else {
            self.isAuthenticated = false
        }
    }

    
    func signUp(email: String, password: String) async {
        do {
            let authResult = try await authService.createUser(withEmail: email, password: password)
            self.user = authResult
            self.isAuthenticated = true
            self.message = nil // Clear any previous error message
            
            try await userService.createNewUser(user: User(id: self.user?.uid ?? "error", name: "Test", email: email))
            
        } catch let error as NSError{
            print("Registration -- code: \(error.code), Description: \(error.localizedDescription)")
            let errorCode = error.code
            // Most common errors
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
            
            print("In AuthViewModel: resetPassword")
            
            try await authService.resetPassword(email: email)
            self.message = "If the email is associated with an account, we'll send a reset password link to your email."
            self.showAlert = true
            self.isSuccess = true
            
        } catch let error as NSError {
            
            self.message = error.localizedDescription
            self.showAlert = true
            self.isSuccess = false
        }
    }
}
