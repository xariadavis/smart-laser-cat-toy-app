//
//  SessionManager.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/16/24.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Combine

class SessionManager: ObservableObject {
    
    @Published var isUserAuthenticated: Bool = false
    @Published var currentUser: AppUser?  // Using the custom type here
    @ObservedObject var patternsManager = PatternsManager.shared
    @ObservedObject var userCatsViewModel = UserCatsViewModel.shared
    private var firestoreManager = FirestoreManager()
    
    // In charge of directing initial view
    @Published var isLoading: Bool = true

    init() {
            Auth.auth().addStateDidChangeListener { [weak self] (_, firebaseUser) in
                guard let self = self, let firebaseUser = firebaseUser else {
                    self?.isUserAuthenticated = false
                    self?.isLoading = false
                    return
                }
                
                // Fetch user data
                self.firestoreManager.fetchUserData(id: firebaseUser.uid) { result in
                    switch result {
                    case .success(let user):
                        self.firestoreManager.fetchCatForUser(id: user.id) { catResult in
                            DispatchQueue.main.async {
                                switch catResult {
                                case .success(let cat):
                                    self.currentUser = user
                                    self.isUserAuthenticated = true
                                    
                                    self.userCatsViewModel.loadUserData(id: user.id)
                                    self.patternsManager.fetchPatterns()
                                    self.isLoading = false
                                case .failure:
                                    // Cat data missing, could trigger onboarding
                                    print("Cat data missing, could trigger onboarding")
                                    self.currentUser = user
                                    self.isUserAuthenticated = false
                                    self.isLoading = false
                                }
                            }
                        }
                    case .failure:
                        DispatchQueue.main.async {
                            print("SessionManager: fetching user FAILED")
                            self.isUserAuthenticated = false
                            self.isLoading = false
                        }
                    }
                }
            }
        }
    
}

extension SessionManager {
    
    func refreshCurrentUser() {
        guard let firebaseUser = Auth.auth().currentUser else {
            self.isUserAuthenticated = false
            return
        }

        print("SessionManager: Refreshing user data...")

        firestoreManager.fetchUserData(id: firebaseUser.uid) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("SessionManager: Refreshed user data successfully -> \(user.id)")
                    self.firestoreManager.fetchCatForUser(id: user.id) { catResult in
                        switch catResult {
                        case .success(let cat):
                            self.currentUser = user
                            self.currentUser?.cat = cat
                            self.isUserAuthenticated = true
                            self.userCatsViewModel.loadUserData(id: user.id)
                            self.patternsManager.fetchPatterns()
                        case .failure:
                            print("Cat data missing, user may need onboarding")
                            self.currentUser = user
                            self.isUserAuthenticated = true
                        }
                    }
                case .failure(let error):
                    print("SessionManager: Failed to refresh user data with error: \(error.localizedDescription)")
                    self.isUserAuthenticated = false
                }
            }
        }
    }
}

