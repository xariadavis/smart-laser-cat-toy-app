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
}
