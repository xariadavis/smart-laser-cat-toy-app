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
    @Published var userID: String = ""
    
    private var authViewModel: AuthViewModel
    private var firestoreManager: FirestoreManager
    
    init(authViewModel: AuthViewModel, firestoreManager: FirestoreManager) {
        self.authViewModel = authViewModel
        self.firestoreManager = firestoreManager
    }
    
    
    // Register user and store information in db
    func register(name: String, email: String, password: String, catName: String, completion: @escaping (Bool, Error?) -> Void) {
        // Check if all fields are valid
        if(!isValid(name: name, email: email, password: password, catName: catName)) {
            DispatchQueue.main.async {
                self.alertMessage = "Please enter all required information"
                self.showAlert = true
            }
            completion(false, nil)
            return
        }
        
        let cat = Cat(name: catName)
        let user = AppUser(id: "", name: name, email: email, password: password, cat: cat)
        
        authViewModel.register(user: user) { [weak self] result in
            switch result {
            case .success(let id):
                // Update the user's id with the one returned from Firebase Auth
                var updatedUser = user
                updatedUser.id = id
                
                self?.firestoreManager.saveUserInfo(user: updatedUser, id: id) { error in
                    DispatchQueue.main.async {
                        if let error = error {
                            print("Failed to save user info: \(error.localizedDescription)")
                            self?.alertMessage = "Failed to complete registration."
                            self?.showAlert = true
                            completion(false, error)
                        } else {
                            print("User info saved successfully")
                            self?.userID = id  // Ensure this property is used correctly in your view models
                            completion(true, nil)
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.alertMessage = error.localizedDescription
                    self?.showAlert = true
                    completion(false, error)
                }
            }
        }
    }

    
    // MARK: Helpers
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
