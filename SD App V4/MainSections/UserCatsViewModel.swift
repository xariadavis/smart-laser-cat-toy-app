//
//  UsersCatsViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/17/24.
//

import Foundation

class UserCatsViewModel: ObservableObject {
    static let shared = UserCatsViewModel()
    
    @Published var user: AppUser = AppUser(id: "", name: "", email: "")
    @Published var cat: Cat = Cat(name: "")
    private var firestoreManager = FirestoreManager()
    
    private init() { }
    
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
    
    func updateCatInfo(id: String, catID: String, updates: [String: Any]) {
        print("UserCatsViewModel: In updateCatInfo the id is \(id) and the cat id is \(catID)")
        firestoreManager.updateCatDataInFirestore(id: id, catID: catID, updates: updates, completion: { result in
            switch result {
            case .success(let success):
                print("Success: \(success)")
            case .failure(let failure):
                print("Failure: \(failure)")
            }
        })
    }
}
