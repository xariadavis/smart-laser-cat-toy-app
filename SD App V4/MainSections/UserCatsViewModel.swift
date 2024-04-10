//
//  UsersCatsViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/17/24.
//

import Foundation
import SwiftUI

class UserCatsViewModel: ObservableObject {
    static let shared = UserCatsViewModel()
    
    @Published var user: AppUser = AppUser(id: "", name: "", email: "")
    @Published var cat: Cat = Cat(name: "")
    @ObservedObject var patternsManager = PatternsManager.shared
    private var firestoreManager = FirestoreManager()
    
    private init() { }
    
    func loadUserData(id: String) {
        firestoreManager.fetchUserData(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
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
                    self?.patternsManager.updateFavoritesStatus(with: cat.favoritePatterns)
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
    
    func updatePlaytimeHistory(userId: String, catId: String, timePlayedToday: Int) {
        firestoreManager.updatePlaytimeHistory(userId: userId, catId: catId, timePlayedToday: timePlayedToday) { error in
            if let error = error {
                print("Failed to update playtime history. \(error.localizedDescription)")
            } else {
                print("Playtime history updated successfully.")
            }
        }
        
    }
    
    func nullifyCat() {
        self.cat.name = ""
        self.cat.sex = ""
        self.cat.weight = 0.0
        self.cat.dailyQuota = 0
        self.cat.timePlayedToday = 0
        self.cat.lastResetDate = Date.now
        self.cat.playtimeHistory = []
        self.cat.breed = ""
        self.cat.age = 0
        self.cat.profilePicture = ""
        self.cat.id = ""
        self.cat.collarColor = ""
        self.cat.favoritePatterns = []
    }
    
    func nullifyUser() {
        self.user.id = ""
        self.user.email = ""
        self.user.name = ""
        self.user.password = ""
    }
}
