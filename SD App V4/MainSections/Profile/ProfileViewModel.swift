//
//  ProfileViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    // Get the firestore manager 
    private var firestoreManager: FirestoreManager
    
    init(firestoreManager: FirestoreManager) {
        self.firestoreManager = firestoreManager
    }
    
//    func uploadProfilePicture(imageData: Data, userID: String, catID: String, completion: @escaping (Result<String, Error>) -> Void) {
//        firestoreManager.uploadImageToFirebase(imageData, userID: userID, catID: catID) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let downloadURL):
//                    print("Successfully uploaded image to firebase storage")
//                    self?.firestoreManager.updateCatDataInFirestore(id: userID, catID: catID, updates: ["profilePicture": downloadURL.absoluteString]) {_ in 
//                        completion(.success(downloadURL.absoluteString))
//                    }
//                case .failure(let error):
//                    completion(.failure(error))
//                    print("Failure in ProfileViewModel: \(error)")
//                }
//            }
//        }
//    }

    
    func fetchNewProfilePicture(userID: String, catID: String, field: String) -> String {
        var returnedValue: String = ""
        
        firestoreManager.fetchCatDataFromFirestore(userID: userID, catID: catID, field: field) { result in
            switch result {
            case .success(let value):
                returnedValue = value
            case .failure(let failure):
                print(failure)
            }
        }
        
        return returnedValue
    }
}
