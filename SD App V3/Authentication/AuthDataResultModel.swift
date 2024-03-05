//
//  AuthDataResultModel.swift
//  SD App V3
//
//  Created by Xaria Davis on 3/4/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String
    let photoUrl: String
    
    init(user: FirebaseAuth.User) {
        self.uid = user.uid
        self.email = user.email ?? "No email"  // TODO: Dummy email
        self.photoUrl = user.photoURL?.absoluteString ?? "No photo url"  // TODO: Default photo
    }
}
