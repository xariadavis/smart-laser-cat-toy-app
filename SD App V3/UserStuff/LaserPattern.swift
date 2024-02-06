//
//  LaserPattern.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/5/24.
//

import Foundation

struct LaserPattern: Identifiable, Codable {
    var id = UUID() // Unique identifier for each pattern
    var name: String
    var description: String
    var iconName: String // Use an asset name or SF Symbol name
    var isFavorite: Bool = false
}

let laserPatterns = [
    LaserPattern(name: "Level 0", description: "Classic circle that provides a gentle introduction to the feline laser chase", iconName: "CirclePattern"),
    LaserPattern(name: "Scarlet Trinity", description: "A trio of arcs that promises triple the fun", iconName: "ThreePattern"),
    LaserPattern(name: "Starry Night", description: "A dazzling starburst for leaping and bounding with delight", iconName: "EightPattern"),
    
    LaserPattern(name: "Flower Quadratica", description: "Intertwining serene loops into a dance of elegance", iconName: "FloralQuadratica"),
    LaserPattern(name: "Crimson Clover Whirl", description: "Chase the lively twirl of a summer's clover.", iconName: "CrimsonCloverWhirl"),
    LaserPattern(name: "Ruby Lattice Spin", description: "An intricate dance of light for a ruby-red geometric maze", iconName: "RubyLatticeSpin"),
    LaserPattern(name: "Sienna Star Chase", description: "Sweeping arms of light beckon with warm, inviting swirls", iconName: "SiennaStarChase")
]


