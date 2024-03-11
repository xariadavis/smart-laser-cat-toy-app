//
//  LoginViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false

    private let authViewModel: AuthViewModel
    
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }
    
    func login(email: String, password: String) {
        authViewModel.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    
                    print("Login successful!")
                    self?.isAuthenticated = true
                    // Proceed with navigating the user to the next screen or updating the UI to reflect the successful login.
                    
                case .failure(let error):
                    
                    // Print the error's localized description to the console
                    print("Login failed with error: \(error.localizedDescription)")
                    
                    // Update the UI to show the error message to the user, for example, through an alert.
                }
            }
        }
    }

    
}
