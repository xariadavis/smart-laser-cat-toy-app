//
//  LaserPattern.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/5/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct LaserPattern: Identifiable, Codable {
    var id: String? // Unique identifier for each pattern
    var name: String
    var description: String
    var iconName: String // Use an asset name
    var isFavorite: Bool
    var omega_1: Int
    var omega_2: Int
    var isPlaying: Bool? = false
    
    // Converts the instance into a dictionary
    func toDictionary() -> [String: Any] {
        return [
            "id" : id,
            "name": name,
            "description": description,
            "iconName": iconName,
            "isFavorite": isFavorite,
            "omega_1": omega_1,
            "omega_2": omega_2
        ]
    }
}
