import SwiftUI
import PhotosUI

struct PhotoPickerView<SelectionView: View>: View {
    @Binding var imageData: Data?
    var userID: String
    var catID: String
    var userCatsViewModel: UserCatsViewModel
    
    @State private var selectedImage: PhotosPickerItem? = nil
    
    // Add a ViewBuilder for the selection view
    private let selectionView: SelectionView
    
    // Initialize with a @ViewBuilder
    init(imageData: Binding<Data?>, userID: String, catID: String, userCatsViewModel: UserCatsViewModel, @ViewBuilder selectionView: () -> SelectionView) {
        self._imageData = imageData
        self.userID = userID
        self.catID = catID
        self.userCatsViewModel = userCatsViewModel
        self.selectionView = selectionView()
    }
    
    var body: some View {
        PhotosPicker(selection: $selectedImage, matching: .images) {
            selectionView
        }
        .onChange(of: selectedImage) { _ in
            loadSelectedImage()
        }
    }
    
    private func loadSelectedImage() {
        guard let selectedImage = selectedImage else { return }
        selectedImage.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let data):
                if let imageData = data {
                    self.imageData = imageData
                    uploadProfilePicture(imageData: imageData)
                } else {
                    print("Error retrieving image data.")
                }
            case .failure(let error):
                print("Failure getting image: \(error)")
            }
        }
    }
    
    private func uploadProfilePicture(imageData: Data) {
        // Use your existing upload logic here. Example:
        userCatsViewModel.uploadProfilePicture(imageData: imageData, userID: userID, catID: catID) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let downloadURL):
                    print("New profile picture URL: \(downloadURL)")
                    userCatsViewModel.cat.profilePicture = downloadURL
                case .failure(let error):
                    print("Error updating profile picture: \(error)")
                }
            }
        }
    }
}
