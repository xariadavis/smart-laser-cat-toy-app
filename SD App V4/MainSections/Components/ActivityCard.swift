//
//  ActivityCard.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/9/24.
//

import SwiftUI
import Foundation

struct ActivityCard: View {
    
    @State var progressValue: Int = 0
    @State var isFirstLoad: Bool = true
    
    @ObservedObject var userCatsViewModel = UserCatsViewModel.shared
    
    // Computed property for playtime
    var timePlayedTodayInMinutes: Int {
        userCatsViewModel.cat.timePlayedToday / 60
    }

    // Computed property for quota
    var dailyQuotaInMinutes: Int {
        userCatsViewModel.cat.dailyQuota / 60
    }

    // Computed property for remaining time
    var timeRemainingInMinutes: Int {
        dailyQuotaInMinutes - timePlayedTodayInMinutes
    }

        
    var body: some View {
                
        ZStack {
            
            HStack() {

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ZStack {
                            KittyProgressBar(progress: self.$progressValue)
                                .frame(width: 14, height: 14)
                                .rotationEffect(Angle.degrees(180))
                                //.offset(x: 115, y: 55)
                                .padding(.leading, 120)
                                .padding(.top, 125)
                                .onAppear {
                                    self.progressValue = getProgressValue(timePlayedToday: timePlayedTodayInMinutes, dailyQuotaInMinutes: dailyQuotaInMinutes)
                                    
                                    print("kljkjlkj \(timePlayedTodayInMinutes)")
                                }
                                .onChange(of: userCatsViewModel.cat.timePlayedToday) { _ in
                                    self.progressValue = getProgressValue(timePlayedToday: timePlayedTodayInMinutes, dailyQuotaInMinutes: dailyQuotaInMinutes)

                                }
                            
                            
                            Text("\(self.progressValue)%")
                                .font(Font.custom("Quicksand-SemiBold", size: 30))
                                .foregroundColor(Color.primary.opacity(0.5))
                                .padding(.top, 10)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                
                Spacer()
                    
                VStack(alignment:.leading, spacing: 15) {
                    
                    let formattedDateString = DateFormatterService.formattedDate()
                    Text(formattedDateString)
                        .font(Font.custom("Quicksand-Bold", size: 20))
                        .foregroundColor(Color.primary)
                    
                    
                    // Weekly Goal
                    VStack(alignment: .leading) {
                        
                        
                        Text("Today's Playtime")
                            .font(Font.custom("Quicksand-Bold", size: 16))
                            .foregroundColor(Color.secondary)
                        
                        Text("\(timePlayedTodayInMinutes)/\(dailyQuotaInMinutes) mins")
                            .font(Font.custom("Quicksand-Semibold", size: 14))
                            .foregroundColor(Color.secondary)
                    }
                    .padding(.trailing, 20)
                    
                    VStack(alignment: .leading) {
                        Text("Time Remaining")
                            .font(Font.custom("Quicksand-Bold", size: 16))
                            .foregroundColor(Color.secondary)
                        
                        Text("\(timeRemainingInMinutes) mins")
                            .font(Font.custom("Quicksand-Semibold", size: 14))
                            .foregroundColor(Color.secondary)
                    }

                }
                .padding(.vertical, 30)
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.fromNeuroKit)
            .cornerRadius(20)

        }
    }
    
    private func getProgressValue(timePlayedToday: Int, dailyQuotaInMinutes: Int) -> Int {
        // Ensure that daily quota is not 0 to avoid division by zero
        guard dailyQuotaInMinutes > 0 else {
            print("Daily quota is 0, which may lead to division by zero.")
            return 0
        }

        // If no time was played today, progress is 0%
        if timePlayedToday == 0 {
            return 0
        }

        // Calculate progress
        let progress = Float(timePlayedToday) / Float(dailyQuotaInMinutes)
        return Int(progress * 100)
    }

}

struct KittyProgressBar: View {
    @Binding var progress: Int
    
    var body: some View {
        ZStack {
            KittyShape()
                .stroke(lineWidth: 12)
                .opacity(0.20)
                .foregroundColor(Color.red.opacity(0.4))
            
            // Check if progress is zero to avoid division by zero
            if progress > 0 {
                KittyShape()
                    .trim(from: 0.0, to: CGFloat(min(Double(self.progress) / 100.0, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundStyle(RadialGradient(gradient: Gradient(colors: [.red, .pink]), center: .center, startRadius: 0, endRadius: 300))
                    .animation(.easeInOut(duration: 1.0), value: progress)
            }
        }
    }
}


struct DateFormatterService {
    static func formattedDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM" // Month
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .ordinal
        let dayOrdinal = numberFormatter.string(from: NSNumber(value: day)) ?? ""
        
        let month = dateFormatter.string(from: date)
        let formattedDate = "\(month) \(dayOrdinal)"
        return formattedDate
    }
    
    static func getLast7DaysRange() -> String {
        let calendar = Calendar.current
        let endDate = Date()
        guard let startDate = calendar.date(byAdding: .day, value: -6, to: endDate) else { return "" }
        
        // Formatter for the month and day
        let monthDayFormatter = DateFormatter()
        monthDayFormatter.dateFormat = "MMMM d"
        
        // Formatter for just the day
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "d"
        
        let startMonthDay = monthDayFormatter.string(from: startDate)
        let endDay = dayFormatter.string(from: endDate)
        
        // Check if start and end dates are in the same month
        if calendar.isDate(startDate, equalTo: endDate, toGranularity: .month) {
            return "\(startMonthDay) - \(endDay)"
        } else {
            let endMonthDay = monthDayFormatter.string(from: endDate)
            return "\(startMonthDay) - \(endMonthDay)"
        }
    }
    
    private static func string(from date: Date, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
}


struct ActivityCard_Previews: PreviewProvider {

    
    static var previews: some View {
        
        @State var progress: Float = 0.1
        
        ActivityCard()
    }
}
