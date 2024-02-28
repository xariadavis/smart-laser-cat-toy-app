//
//  User.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/22/24.
//

import Foundation

struct User: Identifiable {
    var id = UUID()
    var name: String
    var cat: Cat
}

// Create a kitty profile
// let MOCK_CAT = Cat(name: "Garfield the Cat 🍝", age: 2, weight: 27.1, sex: "Male", breed: "Persian")
let MOCK_CAT = Cat(name: "Sir Walter Honey Bee 🐝", age: 2, weight: 15.4, sex: "Male", breed: "DMH")

// Create a user and link them to the kitty profile
let MOCK_USER = User(name: "Jon Arbuckle", cat: MOCK_CAT)
