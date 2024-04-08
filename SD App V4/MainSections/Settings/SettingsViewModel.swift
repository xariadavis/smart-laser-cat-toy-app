//
//  SettingsViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    private let authViewModel: AuthViewModel
    private var firestoreManager: FirestoreManager
    
    @Published private var selectedOption: UpdateOption?
    @Published private var isUpdating: Bool = false
    
    @Published var updatedValue: String = ""
    @Published var title: String = ""
    @Published var field: String = ""
    
    init(authViewModel: AuthViewModel, firestoreManager: FirestoreManager) {
        self.authViewModel = authViewModel
        self.firestoreManager = firestoreManager
    }
    
    func selectOption(_ option: UpdateOption) {
        self.selectedOption = option
        self.title = option.titleAndField.title
        self.field = option.titleAndField.field
    }
    
    func updateUserField(id: String, updates: [String: Any]) {
        firestoreManager.updateUserInfo(id: id, updates: updates) { result in
            switch result {
            case .success(let success):
                print("yay")
            case .failure(let failure):
                print("awe")
            }
        }
    }
    
    // update value
    func updateCatField(id: String, catID: String, updates: [String : Any]) {
        firestoreManager.updateCatDataInFirestore(id: id, catID: catID, updates: updates) { _ in
            print("Updating hopefully")
        }
    }
    
    func logOut() {
        authViewModel.signOut()
    }
    
}

