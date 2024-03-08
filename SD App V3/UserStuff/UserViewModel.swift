//
//  UserViewModel.swift
//  SD App V3
//
//  Created by Xaria Davis on 3/7/24.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var currentUser: User?
    
    init() {
        loadUserPostCache()
    }
    
    func loadUserPostCache() {
        
        print("UserViewModel: loadUser() called")
        
        if let userData = UserDefaults.standard.data(forKey: "cachedUser") {
            let decoder = JSONDecoder()
            self.currentUser = try? decoder.decode(User.self, from: userData)
        }
        
        print("\(currentUser?.name ?? "cry")")
    }
    
    // Add methods to saveUser, updateUser, etc., as needed
}
