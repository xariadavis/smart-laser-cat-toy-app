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
    private var sessionManager: SessionManager
    
    @ObservedObject var userCatsViewModel = UserCatsViewModel.shared
    
    @Published var selectedOption: UpdateOption?
    @Published private var isUpdating: Bool = false
    @Published var updatedValue: String = ""
    @Published var title: String = ""
    @Published var field: String = ""
    
    init(authViewModel: AuthViewModel, firestoreManager: FirestoreManager, sessionManager: SessionManager) {
        self.authViewModel = authViewModel
        self.firestoreManager = firestoreManager
        self.sessionManager = sessionManager
    }
    
    func selectOption(_ option: UpdateOption) {
        self.selectedOption = option
        self.title = option.titleAndField.title
        self.field = option.titleAndField.field
    }
    
    func handleUpdate(option: UpdateOption, textInput: String, pickerSelection: Int) {
        let updatedValue: Any
        switch option {
        case .age:
            updatedValue = pickerSelection
        case .dailyQuota:
            updatedValue = pickerSelection * 60
        case .weight:
            updatedValue = Double(textInput) ?? 0.0
        default:
            updatedValue = textInput
        }

        performUpdate(with: updatedValue)
        
    }

    private func performUpdate(with updatedValue: Any) {
        guard let option = selectedOption else { return }

        let fieldValue = convertUpdatedValue(for: option, updatedValue: updatedValue)

        let updates: [String: Any]
        if let fieldValueAsString = fieldValue as? String {
            updates = [option.titleAndField.field: fieldValueAsString]
        } else if let fieldValueAsInt = fieldValue as? Int {
            updates = [option.titleAndField.field: fieldValueAsInt]
        } else if let fieldValueAsDouble = fieldValue as? Double {
            updates = [option.titleAndField.field: fieldValueAsDouble]
        } else {
            updates = [:]
        }

        if option.titleAndField.title == "User" {
            updateUserField(id: userCatsViewModel.user.id, updates: updates)
        } else if option.titleAndField.title == "Cat" {
            updateCatField(id: userCatsViewModel.user.id, catID: userCatsViewModel.cat.id ?? "", updates: updates)
            if selectedOption == .dailyQuota {
                updateCatField(id: userCatsViewModel.user.id, catID: userCatsViewModel.cat.id ?? "", updates: ["timeRemaining" : (fieldValue as? Int ?? 0) - userCatsViewModel.cat.timePlayedToday])
            }
        }

        sessionManager.refreshCurrentUser()

        self.selectedOption = nil
    }

    
    private func convertUpdatedValue(for option: UpdateOption, updatedValue: Any) -> Any {
        
        guard let stringValue = updatedValue as? String else { return updatedValue }
        
        switch option {
        case .age, .dailyQuota:
            return Int(stringValue) ?? 0
        case .weight:
            return Double(stringValue) ?? 0.0
        case .email, .usersName, .catsName, .collarColor:
            return stringValue
        }
    }

    
    func updateUserField(id: String, updates: [String: Any]) {
        firestoreManager.updateUserInfo(id: id, updates: updates) { result in
            switch result {
            case .success(_):
                print("yay")
            case .failure(_):
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

