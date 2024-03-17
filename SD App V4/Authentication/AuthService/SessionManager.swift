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

    init() {
        Auth.auth().addStateDidChangeListener { [weak self] (_, firebaseUser) in
            withAnimation {
                self?.isUserAuthenticated = firebaseUser != nil
                // Convert FirebaseAuth.User to AppUser
                if let firebaseUser = firebaseUser {
                    self?.currentUser = AppUser(uid: firebaseUser.uid, name: firebaseUser.displayName ?? "", email: firebaseUser.email ?? "")
                } else {
                    self?.currentUser = nil
                }
            }
        }
    }
    
}

