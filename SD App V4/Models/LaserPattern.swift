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
    var iconName: String // Use an asset name
    var isFavorite: Bool = false
    var omega_1: Int
    var omega_2: Int
}

let laserPatterns = [
    LaserPattern(name: "Level 0", description: "Classic circle provides a gentle introduction to the laser chase", iconName: "CirclePattern", isFavorite: false, omega_1: 1, omega_2: 1),
    LaserPattern(name: "Scarlet Trinity", description: "A trio of arcs that promises triple the fun", iconName: "ThreePattern", isFavorite: false, omega_1: 1, omega_2: -2),
    LaserPattern(name: "Starry Night", description: "A dazzling starburst for leaping and bounding with delight", iconName: "EightPattern", isFavorite: true, omega_1: 3, omega_2: -5),
    LaserPattern(name: "Flower Quadratica", description: "Intertwining serene loops into a dance of elegance", iconName: "FloralQuadratica", isFavorite: true, omega_1: 3, omega_2: -1),
    LaserPattern(name: "Crimson Clover Whirl", description: "Chase the lively twirl of a summer's clover", iconName: "CrimsonCloverWhirl", isFavorite: false, omega_1: 2, omega_2: -5),
    LaserPattern(name: "Nexus", description: "Four intersecting circles create a nexus of energy and connection", iconName: "Nexus", isFavorite: true, omega_1: 1, omega_2: 4),
    LaserPattern(name: "Twin Tails", description: "Mirrored arcs evoke a cat's agile movements in a whimsical dance", iconName: "TwinTails",isFavorite: false , omega_1: 1, omega_2: 3),
    LaserPattern(name: "Lone Pounce", description: "A solitary loop invites a singular leap", iconName: "LonePounce", isFavorite: false, omega_1: 2, omega_2: 1),
    LaserPattern(name: "Heartfelt Orbit", description: "Nested loops form a subtle heart within a sweeping circle", iconName: "HeartfeltOrbit", isFavorite: true, omega_1: 2, omega_2: 3),
    LaserPattern(name: "Bloom Array", description: "Symmetrical loops converge into a striking floral design", iconName: "BloomArray", isFavorite: true, omega_1: 1, omega_2: -6),
    LaserPattern(name: "Spiral Echo", description: "A single loop spirals outward, symbolizing expansion and flow", iconName: "SpiralEcho", isFavorite: false, omega_1: 4, omega_2: 3),
    LaserPattern(name: "Triple Entwine", description: "A trio of interlaced loops within a circle, signifying unity.", iconName: "TripleEntwine", isFavorite: false, omega_1: 3, omega_2: 5),
    LaserPattern(name: "Traid Link", description: "Clover-like emblem of interconnectedness", iconName: "TriadLink", isFavorite: false, omega_1: 2, omega_2: 5),
    LaserPattern(name: "Quartet Harmony", description: "Four intertwined loops gracefully form a floral symmetry", iconName: "QuartetHarmony", isFavorite: true, omega_1: 1, omega_2: 5),
    LaserPattern(name: "Convergence", description: "Curved paths weave together, crafting a playful pattern", iconName: "Convergence", isFavorite: false, omega_1: 1, omega_2: 6),
    LaserPattern(name: "Whisker's Embrace", description: "Nested within sweeping circles, a tender heart emerges", iconName: "WhiskersEmbrace", isFavorite: true, omega_1: 4, omega_2: 5)
]

