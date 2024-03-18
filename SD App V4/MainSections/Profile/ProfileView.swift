//
//  ProfileView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var userCatsViewModel: UserCatsViewModel
    
    var body: some View {
        ZStack {
            
            background
            contentScrollView
        }
        .ignoresSafeArea()
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
        Image("MOCK_PFP")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
            .clipped()
    }

    private var infoSection: some View {
        VStack(alignment: .leading) {
            sectionTitle("\(userCatsViewModel.cat.name)", fontSize: 25)
            Group {
                HStack {
                    InfoCard(iconName: "clock", title: "Age", detail: "\(userCatsViewModel.cat.age) years")
                    InfoCard(iconName: "pawprint", title: "Breed", detail: "DMH")
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
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
