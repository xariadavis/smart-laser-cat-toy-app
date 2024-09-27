//
//  PatternManager.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/12/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class PatternsManager: ObservableObject {

    static let shared = PatternsManager()
    
    @Published var patterns = [LaserPattern]()
    
    private var db = Firestore.firestore()
    
    private init() { }
    
    func fetchPatterns() {
        // Switching to 'patterns' from 'working_patterns' to showcase all possibe patterns
        db.collection("patterns").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.patterns = documents.compactMap { queryDocumentSnapshot in
                try? queryDocumentSnapshot.data(as: LaserPattern.self)
            }            
        }
    }
    
    // Function to refresh favorites based on an array of favoriteIds
    func updateFavoritesStatus(with favoriteIds: [String]) {
        // Iterate over the patterns and update the isFavorite property
        patterns = patterns.map { pattern in
            var modifiedPattern = pattern
            if favoriteIds.contains(pattern.id ?? "") {
                modifiedPattern.isFavorite = true
            } else {

                // modifiedPattern.isFavorite = false
            }
            return modifiedPattern
        }
    }
    
    
    func toggleFavorite(for patternId: String, userId: String, catId: String) {
        let catRef = db.collection("users").document(userId).collection("cats").document(catId)
        
        // First, check if the pattern is already a favorite to determine the action
        isFavorite(userId: userId, catId: catId, patternId: patternId) { [weak self] isFavorite in
            guard let self = self else { return }

            // Locally toggle the isFavorite status of the pattern
            if let index = self.patterns.firstIndex(where: { $0.id == patternId }) {
                self.patterns[index].isFavorite.toggle()

                // Depending on the current favorite status, add or remove from Firestore
                if isFavorite {
                    self.removeFavorite(userId: userId, catId: catId, patternId: patternId)
                } else {
                    self.addFavorite(userId: userId, catId: catId, patternId: patternId)
                }
            }
        }
    }
    
    // Add a pattern to the favorites array using arrayUnion
    func addFavorite(userId: String, catId: String, patternId: String) {
        let catRef = db.collection("users").document(userId).collection("cats").document(catId)
        catRef.updateData([
            "favoritePatterns": FieldValue.arrayUnion([patternId])
        ]) { error in
            if let error = error {
                print("Error adding pattern to favorites: \(error)")
            } else {
                print("Pattern \(patternId) added to favorites successfully.")
            }
        }
    }
    
    // Remove a pattern from the favorites array using arrayRemove
    func removeFavorite(userId: String, catId: String, patternId: String) {
        let catRef = db.collection("users").document(userId).collection("cats").document(catId)
        catRef.updateData([
            "favoritePatterns": FieldValue.arrayRemove([patternId])
        ]) { error in
            if let error = error {
                print("Error removing pattern from favorites: \(error)")
            } else {
                print("Pattern \(patternId) removed from favorites successfully.")
            }
        }
    }

    // Function to check if a pattern is already marked as favorite
    func isFavorite(userId: String, catId: String, patternId: String, completion: @escaping (Bool) -> Void) {
        let catRef = db.collection("users").document(userId).collection("cats").document(catId)
        catRef.getDocument { document, error in
            guard let document = document, document.exists, let favoritePatterns = document.get("favoritePatterns") as? [String] else {
                print("Document not found or favoritePatterns field is missing")
                completion(false)
                return
            }
            completion(favoritePatterns.contains(patternId))
        }
    }
}
