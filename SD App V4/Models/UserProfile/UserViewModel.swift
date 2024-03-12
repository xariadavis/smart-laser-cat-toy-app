//
//  UserViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/11/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var cat: Cat?

    private let db = Firestore.firestore()
    
    func fetchUserProfile(uid: String) {
        // Fetch the user's basic information
        db.collection("users").document(uid).getDocument { [weak self] (document, error) in
            guard let self = self, let document = document, document.exists else {
                print("User not found")
                return
            }
            
            let userData = document.data()
            let name = userData?["name"] as? String ?? ""
            let email = userData?["email"] as? String ?? ""

            // Initialize the User object with basic info for now
            self.user = User(uid: uid, name: name, email: email)
            
            // Proceed to fetch the cat's information
            self.fetchCatForUser(uid: uid)
        }
    }
    
    func fetchCatForUser(uid: String) {
        // Assuming there's only one cat per user, we can limit the query to fetch only one document
        db.collection("users").document(uid).collection("cats").limit(to: 1).getDocuments { [weak self] (querySnapshot, error) in
            guard let document = querySnapshot?.documents.first else {
                print("Cat not found")
                return
            }
            
            let catData = document.data()
            let catId = document.documentID
            let catName = catData["name"] as? String ?? ""

            // Assuming Cat has an initializer that accepts an ID and a name
            self?.cat = Cat(id: catId, name: catName)
            
            // If needed, update the user model here with the cat information
            if let user = self?.user {
                self?.user = User(uid: user.uid, name: user.name, email: user.email, cat: self?.cat)
            }
        }
    }
    
}
