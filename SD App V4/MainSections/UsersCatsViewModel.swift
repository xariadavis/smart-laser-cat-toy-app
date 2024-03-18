//
//  UsersCatsViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/17/24.
//

import Foundation

class UserCatsViewModel: ObservableObject {
    
    @Published var user: AppUser = AppUser(id: "", name: "", email: "")
    @Published var cat: Cat = Cat(name: "")
    private var firestoreManager = FirestoreManager()
    
    func loadUserData(id: String) {
        print("UserCatsViewModel: In loadUserData the id is \(id)")
        firestoreManager.fetchUserData(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Successfully fetched user: \(user)")
                    self?.user = user
                case .failure(let error):
                    print("Error fetching user data: \(error)")
                }
            }
        }
        
        firestoreManager.fetchCatForUser(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cat):
                    self?.cat = cat
                    print("Fetched: \(cat)")
                case .failure(let error):
                    print("Error fetching cats data: \(error)")
                }
            }
        }
    }
}
