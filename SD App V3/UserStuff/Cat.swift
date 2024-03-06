//
//  Cat.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/22/24.
//

import Foundation

struct Cat: Identifiable, Codable {
    var id: String?
    var ownerID: String?
    var name: String
    var age: Int?
    var weight: Float?
    var sex: String?
    var breed: String?
    var favoritePatterns: [String]

    // Modified initializer to include all properties
    init(id: String? = nil, ownerID: String? = nil, name: String, age: Int? = nil, weight: Float? = nil, sex: String? = nil, breed: String? = nil, favoritePatterns: [String] = []) {
        self.id = id
        self.ownerID = ownerID
        self.name = name
        self.age = age
        self.weight = weight
        self.sex = sex
        self.breed = breed
        self.favoritePatterns = favoritePatterns
    }
}
