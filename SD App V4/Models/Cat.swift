//
//  Cat.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import Foundation

struct Cat: Codable {
    
    var id: String?
    var name: String
    var breed: String = ""
    var sex: String?
    var age: Int = 0
    var weight: Double?
    var color: String?
    
}
