//
//  ListCard.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/4/24.
//

import SwiftUI
import Neumorphic

struct ActivityCard: View {
    
    @State var progressValue: Float = 0.0
    @State var isFirstLoad: Bool = true
        
    var body: some View {

        ZStack {
            
            HStack() {

                KittyProgressBar(progress: self.$progressValue)
                    .frame(width: 14, height: 14)
                    .rotationEffect(Angle.degrees(180))
                    .offset(x: 125, y: 60)
                    .padding(20)
                    .onAppear() {
                        self.progressValue = 0.6
                    }
                
                // (progress * 100)
                Text("\(Int(self.progressValue * 100))%")
                    .font(Font.custom("Quicksand-SemiBold", size: 30))
                    .foregroundColor(Color.primary.opacity(0.5))
                
                Spacer()
                    
                VStack(alignment:.leading, spacing: 15) {
                    
                    let formattedDateString = DateFormatterService.formattedDate()
                    Text(formattedDateString)
                        .font(Font.custom("Quicksand-Bold", size: 20))
                        .foregroundColor(Color.primary)
                    
                    
                    // Weekly Goal
                    VStack(alignment: .leading) {
                        Text("Today's playtime")
                            .font(Font.custom("Quicksand-Bold", size: 16))
                            .foregroundColor(Color.secondary)
                        
                        Text("18/30 mins")
                            .font(Font.custom("Quicksand-Semibold", size: 14))
                            .foregroundColor(Color.secondary)
                    }
                    .padding(.trailing, 20)
                    
                    VStack(alignment: .leading) {
                        Text("Left this week")
                            .font(Font.custom("Quicksand-Bold", size: 16))
                            .foregroundColor(Color.secondary)
                        
                        Text("80 mins")
                            .font(Font.custom("Quicksand-Semibold", size: 14))
                            .foregroundColor(Color.secondary)
                    }

                }
                .offset(y: -5)
                .padding(.vertical, 30)
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.Neumorphic.main)
            .cornerRadius(20)

        }
    }
}

struct KittyProgressBar: View {
    @Binding var progress: Float
    
    var color: Color = Color.green
    
    var body: some View {
        ZStack {
            KittyShape()
                .stroke(lineWidth: 12)
                .opacity(0.20)
                .foregroundColor(Color.red.opacity(0.4))
            KittyShape()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round,
                                           lineJoin: .round))
                .foregroundStyle(RadialGradient(gradient: Gradient(colors: [.red, .pink]), center: .center, startRadius: 0, endRadius: 300))
                .animation(.easeInOut(duration: 1.0), value: progress)
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
}


struct ActivityCard_Previews: PreviewProvider {

    
    static var previews: some View {
        
        @State var progress: Float = 0.1
        
        ActivityCard()
    }
}
