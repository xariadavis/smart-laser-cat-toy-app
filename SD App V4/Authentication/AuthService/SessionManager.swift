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
    private var firestoreManager = FirestoreManager()
    @EnvironmentObject var userCatsViewModel: UserCatsViewModel
    
    // In charge of directing initial view
    @Published var isLoading: Bool = true

    
    init() {
            Auth.auth().addStateDidChangeListener { [weak self] (_, firebaseUser) in
                guard let self = self, let firebaseUser = firebaseUser else {
                    self?.isUserAuthenticated = false
                    return
                }
                
                // Fetch user data
                print("SessionManager: fetching user...")
                self.firestoreManager.fetchUserData(id: firebaseUser.uid) { result in
                    switch result {
                    case .success(let user):
                        print("SessionManager: fetching user SUCCESS")
                        self.firestoreManager.fetchCatForUser(id: user.id) { catResult in
                            DispatchQueue.main.async {
                                switch catResult {
                                case .success(let cat):
                                    
                                    self.currentUser = user
                                    print("SessionManager: \(self.currentUser?.id)")
                                    self.isUserAuthenticated = true
                                    self.patternsManager.fetchPatterns()
                                    self.isLoading = false
                                case .failure:
                                    // Cat data missing, could trigger onboarding
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

