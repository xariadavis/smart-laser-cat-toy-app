//
//  User.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import Foundation

struct User {
    
    var uid: String
    var name: String
    var email: String
    var password: String?
    var cat: Cat?
    
    init(uid: String, name: String, email: String, password: String? = "", cat: Cat? = nil) {
        self.uid = uid
        self.name = name
        self.email = email
        self.password = password
        self.cat = cat
    }
    
}
