//
//  ProfileView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI
import PhotosUI
import Kingfisher


struct ProfileView: View {
    
    @ObservedObject var patternsManager = PatternsManager.shared
    @ObservedObject var userCatsViewModel = UserCatsViewModel.shared
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel
    
    @StateObject var viewModel: ProfileViewModel
    
    @State private var selectedImage: [PhotosPickerItem] = []
    @State private var imageData: Data?
    
    
    
    var body: some View {
        ZStack {
            background
            contentScrollView
        }
        .ignoresSafeArea()
        .sheet(isPresented: $timerViewModel.showingPatternCover) {
            if let pattern = timerViewModel.currentPattern {
                PatternDetailCover(pattern: .constant(pattern), isConnected: bluetoothViewModel.isConnected) {
                    timerViewModel.showingPatternCover = false
                }
            }
        }
    }
    
    private var background: some View {
        Color(.systemGray5).ignoresSafeArea()
    }
    
    private var contentScrollView: some View {
        ScrollView {
            VStack(spacing: 20) {
                profileImage
                infoSection
                favoritesSection
                activitySection
                totalPlaytimeSection
            }
            .padding(.bottom, 120)
        }
    }

    
    private var profileImage: some View {
        ZStack(alignment: .bottomTrailing) { // Use ZStack to overlay the photo picker button on the image
            // Display the current profile image
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                    .clipped()
            } else if let profilePictureURL = URL(string: userCatsViewModel.cat.profilePicture ?? ""), userCatsViewModel.cat.profilePicture != "" {
                KFImage(profilePictureURL) // Assuming you're using Kingfisher for URL images
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                    .clipped()
            } else {
                // Fallback or placeholder image
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .font(.system(size: 150))
                    .padding()
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
            }
            
            PhotoPickerView(
                imageData: $imageData,
                userID: userCatsViewModel.user.id,
                catID: userCatsViewModel.cat.id ?? "",
                userCatsViewModel: userCatsViewModel
            ) {
                // Custom appearance for the selection view
                HStack {
                    Image(systemName: "photo.circle.fill")
                        .font(.system(size: 25))
                        .frame(width: 25)
                        .foregroundColor(Color(.systemGray5))
                        .shadow(radius: 5)
                }
                .padding(1)
                .background(Capsule().strokeBorder(Color.red, lineWidth: 1))
                .padding() // Add padding to ensure it's not touching the edges
                .padding(.bottom, 25)
            }
        }
        .frame(height: UIScreen.main.bounds.height / 2)
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading) {
            sectionTitle("\(userCatsViewModel.cat.name)", fontSize: 25)
            Group {
                HStack {
                    var age = userCatsViewModel.cat.age
                    InfoCard(iconName: "clock", title: "Age", detail: "\(age) \(age == 1 ? "year" : "years")")
                    InfoCard(iconName: "pawprint", title: "Breed", detail: "\(formatBreedName(userCatsViewModel.cat.breed))")
                }
                HStack {
                    InfoCard(iconName: "person", title: "Sex", detail: "\(userCatsViewModel.cat.sex ?? "")")
                    InfoCard(iconName: "scalemass", title: "Weight", detail: "\(userCatsViewModel.cat.weight ?? 0.00) lbs")
                }
            }
            .padding(.horizontal)
        }
        .background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray5)))
        .padding(.top, -50)
    }
    
    func formatBreedName(_ breedName: String) -> String {
        // Check if breed name is longer than 10 letters
        if breedName.count > 10 {
            // Split the breed name into words
            let words = breedName.split(separator: " ")
            
            // If the breed name consists of more than one word
            if words.count > 1 {
                // Return the initials of each word
                return words.reduce("") { partialResult, word in
                    partialResult + word.prefix(1)
                }
            } else {
                // If it is a single word, return the first 7 characters followed by "..."
                return String(breedName.prefix(7)) + "..."
            }
        } else {
            // If none of the conditions are met, return the breed name as is
            return breedName
        }
    }
    
    
    private var favoritesSection: some View {
        VStack(alignment: .leading) {
            sectionTitle("Favorites")
            FavoritesCarousel(width: 150, height: 150)
                .padding(.horizontal)
        }
    }
    
    private var activitySection: some View {
        VStack(alignment: .leading) {
            sectionTitle("Activity")
            ActivityCard()
                .padding(.horizontal)
        }
    }
    
    private var totalPlaytimeSection: some View {
        VStack {
            Text("Total Playtime")
                .font(Font.custom("Quicksand-Bold", size: 20))
                .foregroundColor(.primary)
                .padding(.bottom, 1)
            
            Text(DateFormatterService.getLast7DaysRange())
                .font(Font.custom("Quicksand-Semibold", size: 17))
                .foregroundColor(.secondary)
            
            Text("2h 45m")
                .font(Font.custom("Quicksand-Semibold", size: 18))
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .padding(.bottom, 20)
            
            WeeklyProgressView()
        }
        .padding(.vertical, 30)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.fromNeuroKit))
        .padding(.horizontal)
    }
    
    private func sectionTitle(_ text: String, fontSize: CGFloat = 23) -> some View {
        Text(text)
            .font(Font.custom("TitanOne", size: fontSize))
            .padding(.horizontal, 30)
            .padding(.top, 20)
    }
    
    struct InfoCard: View {
        var iconName: String
        var title: String
        var detail: String
        
        var body: some View {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.red)
                    .frame(width: 35, height: 35)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(Font.custom("Quicksand-Semibold", size: 15))
                        .foregroundColor(.secondary)
                    Text(detail)
                        .font(Font.custom("Quicksand-Semibold", size: 16))
                        .fontWeight(.bold)
                }
                Spacer()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.fromNeuroKit))
            .frame(maxWidth: .infinity)
        }
        
    }
    
    
    struct Rounded: Shape {
        
        func path(in rect: CGRect) -> Path {
            
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
            
            return Path(path.cgPath)
        }
    }
    
    
    struct BarView: View {
        
        var playtimeValue: CGFloat
        var barValue: CGFloat
        var day: String
        
        var body: some View {
            
            VStack {
                ZStack(alignment: .bottom) {
                    Capsule()
                        .frame(width: 15, height: 150)
                        .foregroundColor(Color.red.opacity(0.2))
                    
                    Capsule()
                        .frame(width: 15, height: barValue)
                        .foregroundColor(Color.red)
                }
                
                Text(day)
                    .font(.system(size: 16))
                    .frame(width: 35, alignment: .center)
                
                Text("\(Int(playtimeValue))m")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
        }
    }
    
    struct WeeklyProgressView: View {
        
        @ObservedObject var userCatsViewModel = UserCatsViewModel.shared
        
        func getLast7Days() -> [Date] {
            let calendar = Calendar.current
            return (0..<7).map { i in
                calendar.date(byAdding: .day, value: -i, to: Date())!
            }.reversed()
        }
        
        func dayAbbreviation(from date: Date) -> String {
            let calendar = Calendar.current
            let dayOfWeek = calendar.component(.weekday, from: date)
            switch dayOfWeek {
            case 1:
                return "Su"
            case 2:
                return "M"
            case 3:
                return "T"
            case 4:
                return "W"
            case 5:
                return "Th"
            case 6:
                return "F"
            case 7:
                return "S"
            default:
                return ""
            }
        }
        
        var body: some View {
            HStack(alignment: .bottom, spacing: 10) {
                Spacer()
                ForEach(0..<getLast7Days().count, id: \.self) { index in
                    if let playtime = userCatsViewModel.cat.playtimeHistory[safe: index] { // Safe subscript
                        
                        let playtimeValue = CGFloat((playtime / 60))  // Time in minutes
                        let scaleFactor = 150.0 /  CGFloat(userCatsViewModel.cat.dailyQuota / 60)
                        let finalValue = playtimeValue * scaleFactor
                        
                        let date = getLast7Days()[index]
                        let day = dayAbbreviation(from: date)
                        
                        BarView(playtimeValue: playtimeValue, barValue: finalValue, day: day)
                    }
                }
                Spacer()
            }
        }
    }
    
    
    struct WeekRangeService {
        static func getLast7DaysRange() -> String {
            let calendar = Calendar.current
            let endDate = Date()
            guard let startDate = calendar.date(byAdding: .day, value: -6, to: endDate) else { return "" }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd"
            
            let startDateString = dateFormatter.string(from: startDate)
            let endDateString = dateFormatter.string(from: endDate)
            
            return "\(startDateString) - \(endDateString)"
        }
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(firestoreManager: FirestoreManager()))
    }
}
