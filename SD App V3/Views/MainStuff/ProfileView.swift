//
//  ProfileView.swift
//  SD App V3
//
//  Created by Xaria Davis on 1/31/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack(alignment: .center) {
            
            // Define background color
            Color(.systemGray5).ignoresSafeArea()
            
            ScrollView {
                VStack {
                    // Image
                    
//                    Image("KittyProfilePic")
                    Image("MOCK_CAT_PFP") // Initialize Image with name
                        .resizable()
                        .scaledToFill() // Fill the ZStack, you can adjust this as needed
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2) // Half the screen height
                        .clipped() // Ensure the image does not exceed its frame
                    
                    
                    // Spacer()
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading) {
                            // Kitty's name
                            Text("\(MOCK_CAT.name)")
                                .font(Font.custom("TitanOne", size: 25))
                                .padding(10)
                            
                            HStack {
                                InfoCard(iconName: "clock", title: "Age", detail: "\(String(describing: MOCK_CAT.age)) years")
                                InfoCard(iconName: "pawprint", title: "Breed", detail: "\(String(describing: MOCK_CAT.breed))")
                            }
                            HStack {
                                InfoCard(iconName: "person", title: "Sex", detail: "\(String(describing: MOCK_CAT.sex))")
                                InfoCard(iconName: "scalemass", title: "Weight", detail: "\(String(describing: MOCK_CAT.weight)) lb")
                            }
                            
                            
                            Text("Favorites")
                                .font(Font.custom("TitanOne", size: 23))
                                .padding(.top, 20)
                            
                            
                            FavoritesCarousel(width: 150, height: 150)
                            
                            Text("Activity")
                                .font(Font.custom("TitanOne", size: 23))
                                .padding(.top, 20)
                            
                            ActivityCard()
                            
                            VStack {
                                // Total calculated playtime this week
                                Text("Total Playtime")
                                    .font(Font.custom("Quicksand-Bold", size: 20))
                                    .foregroundColor(.primary)
                                    .padding(.bottom, 1)
                                
                                let last7DaysRange = DateFormatterService.getLast7DaysRange()
                                Text(last7DaysRange)
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
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main))
                            
                            // Last Play Session
                            
                            
                            
                            
                        }
                        .padding()
                        
                    }
                    .background(Rounded().fill(Color(.systemGray5)))
                    .padding(.top, -50)
                    
                    Spacer()
                    
                }
                .padding(.bottom, 95)
                
            }
            .ignoresSafeArea()
        }
    }
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
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main))
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
    
    var value: CGFloat
    var day: String

    var body: some View {
        
        VStack {
            ZStack(alignment: .bottom) {
                Capsule()
                    .frame(width: 15, height: 150)
                    .foregroundColor(Color.red.opacity(0.2))
                
                Capsule()
                    .frame(width: 15, height: value)
                    .foregroundColor(Color.red)
            }
            
            Text(day)
                .font(.system(size: 16))
                .frame(width: 35, alignment: .center)
            
            Text("\(Int((value / 150) * 100))m")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
    }
}

struct WeeklyProgressView: View {
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
        HStack(alignment: .center, spacing: 10) {
            Spacer()
            ForEach(getLast7Days(), id: \.self) { date in
                let value = CGFloat(Int.random(in: 20...120)) // Replace with actual data
                BarView(value: value, day: dayAbbreviation(from: date))
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
