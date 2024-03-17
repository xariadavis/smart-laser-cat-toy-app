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
    func register(name: String, email: String, password: String, catName: String) {
        
        // Check if all fields are valid
        if(!isValid(name: name, email: email, password: password, catName: catName)) {
            self.registrationSuccessful = false
            self.alertMessage = "Please enter all required information"
            self.showAlert = true
            return
        }
                
        let cat = Cat(name: catName)
        let user = AppUser(uid: "", name: name, email: email, password: password, cat: cat)
        
        authViewModel.register(user: user, completion: { [weak self] result in
            switch result {
            case .success(let uid):
                
                DispatchQueue.main.async {
                    print("Registration successful!")
                    self?.registrationSuccessful = true
                    
                    // Update the user's UID with the one returned from Firebase Auth
                    var updatedUser = user
                    updatedUser.uid = uid
                    
                    self?.firestoreManager.saveUserInfo(user: updatedUser, uid: uid) { error in
                        if let error = error {
                            print("Failed to save user info: \(error.localizedDescription)")
                        } else {
                            print("User info saved successfully")
                            self?.userID = uid  // Correctly update the published userID property
                            print("The user id is \(self?.userID)")
                        }
                    }
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
