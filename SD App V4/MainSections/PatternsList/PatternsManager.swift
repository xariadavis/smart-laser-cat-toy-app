//
//  PatternManager.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/12/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class PatternsManager: ObservableObject {
    static let shared = PatternsManager()
    
    @Published var patterns = [LaserPattern]()
    private var db = Firestore.firestore()
    
    private init() { }
    
    func fetchPatterns() {
        db.collection("patterns").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.patterns = documents.compactMap { queryDocumentSnapshot in
                try? queryDocumentSnapshot.data(as: LaserPattern.self)
            }
        }
        
        print("Patterns fetched!")
    }
    
    // Assuming patternId is already a String that matches the Firestore document ID
    func toggleFavorite(for patternId: String) {
        guard let index = patterns.firstIndex(where: { $0.id == patternId }) else { return }
        let isFavorite = patterns[index].isFavorite
        patterns[index].isFavorite.toggle() // Toggle locally

        // Update Firestore
        db.collection("patterns").document(patternId).updateData([
            "isFavorite": !isFavorite  // Toggle the value in Firestore
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
                self.patterns[index].isFavorite = isFavorite  // Revert if there was an error
            } else {
                print("Document successfully updated")
            }
        }
    }
}
