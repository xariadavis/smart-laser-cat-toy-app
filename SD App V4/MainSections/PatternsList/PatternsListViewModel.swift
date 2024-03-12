//
//  PatternsListViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class PatternsViewModel: ObservableObject {
    @Published var patterns = [LaserPattern]()

    private var db = Firestore.firestore()
    
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
