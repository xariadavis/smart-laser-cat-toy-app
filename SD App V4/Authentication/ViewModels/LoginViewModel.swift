//
//  LoginViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoggedIn: Bool = false

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
                    self?.isLoggedIn = true
                    
                case .failure(let error):
                    
                    // Print the error's localized description to the console
                    print("Login failed with error: \(error.localizedDescription)")
                    self?.alertMessage = error.localizedDescription
                    self?.showAlert = true
                    self?.isLoggedIn = false
                    
                    // Update the UI to show the error message to the user
                }
            }
        }
    }

    
}
