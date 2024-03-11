//
//  SignUpViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import Foundation

@MainActor
class SignUpViewModel: ObservableObject {
    
    @Published var registrationSuccessful: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    private let authViewModel: AuthViewModel
    
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }
    
    func register(name: String, email: String, password: String, catName: String) {
        
        if(!isValid(name: name, email: email, password: password, catName: catName)) {
            
            self.registrationSuccessful = false
            self.alertMessage = "Please enter all required information"
            self.showAlert = true
            
            return
            
        }
        
        // Define the user
        let cat = Cat(name: catName)
        let user = User(uid: "", name: name, email: email, password: password, cat: cat)
                
        // Call function and pass user
        authViewModel.register(user: user, completion: { [weak self] result in
            switch result {
            case .success():
                // Handle success, update UI accordingly
                // Since we're in a closure, make sure to dispatch any UI updates to the main thread
                DispatchQueue.main.async {
                    // Update UI to show success, navigate to the next screen, etc.
                    print("Registration successful!")
                    self?.registrationSuccessful = true
                }
            case .failure(let error):
                // Handle failure, update UI accordingly
                DispatchQueue.main.async {
                    self?.registrationSuccessful = false
                    self?.alertMessage = error.localizedDescription
                    self?.showAlert = true
                    print("Registration failed :( \(error.localizedDescription)")
                }
            }
            
        })
    }
    
    func isValid(name: String, email: String, password: String, catName: String) -> Bool {
        if (name.trimmingCharacters(in: .whitespaces).isEmpty ||
            catName.trimmingCharacters(in: .whitespaces).isEmpty ||
            email.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty) {
            
            return false
        } else {
            return true
        }
        
    }
}
