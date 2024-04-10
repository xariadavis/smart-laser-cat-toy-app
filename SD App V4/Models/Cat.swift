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
    var collarColor: String?
    var dailyQuota: Int = 1800
    var timePlayedToday: Int = 0
    var timeRemaining: Int = 1800
    var lastResetDate: Date = Date.now
    var playtimeHistory: [Int] = [0, 0, 0, 0, 0, 0, 0]
    var profilePicture: String = ""
    var favoritePatterns: [String] = []
}
