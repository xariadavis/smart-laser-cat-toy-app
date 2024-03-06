//
//  User.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/22/24.
//

import Foundation

struct User: Identifiable, Codable {
    
    var id: String
    var name: String
    var email: String
    var catID: String  // Store the cats ID for reference

}
