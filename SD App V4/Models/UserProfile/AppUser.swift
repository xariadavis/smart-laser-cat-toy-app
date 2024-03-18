//
//  User.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import Foundation

struct AppUser: Codable {
    
    var id: String
    var name: String
    var email: String
    var password: String?
    var cat: Cat?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case password
        case cat
    }
    
    init(id: String, name: String, email: String, password: String? = "", cat: Cat? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.cat = cat
    }
    
}
