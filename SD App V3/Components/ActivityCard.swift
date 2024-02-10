//
//  ListCard.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/4/24.
//

import SwiftUI
import Neumorphic
import PZCircularControl

struct ActivityCard: View {
    
    @Binding var progress: Float
    
    var body: some View {
        
        // Important things to implement
            // - Have a goal amount of time want cat to play
            // - Have a progress bar
            // - Have a daily and a weekly tracker
        
        // Stretch
            // - Having daily progress will be stretch; also requires more user information
            // - Streaks?

        ZStack {
  
            Rectangle()
                .fill(Color.Neumorphic.main)
                .frame(width: 350, height: 200)
                .cornerRadius(20)
                .padding(.horizontal, 20)
            
            HStack(spacing: 30) {
                
                ZStack {
                    
                    PZCircularControl(
                        PZCircularControlParams(
                            innerBackgroundColor: Color.clear,
                            outerBackgroundColor: Color.red.opacity(0.3),
                            tintColor: LinearGradient(gradient: Gradient(colors: [.red, .myRed]), startPoint: .bottomLeading, endPoint: .topLeading),
                            textColor: Color.primary.opacity(0.5),
                            barWidth: 12.0,
                            glowDistance: 0.0,
                            font: Font.custom("Quicksand-Regular", size: 30),
                            initialValue: CGFloat(Float.random(in: 0...1))
                        )
                    )
                    .frame(width: 120)
                }
                
                VStack(spacing: 20) {
                    // Good job or something?
                    Text("Nice Effort!")
                        .font(Font.custom("Quicksand-Bold", size: 23))
                        .foregroundColor(Color.primary)
                        .offset(x: -10)
                    
                    // Weekly Goal
                    Text("10/100 mins of \npawsome play 🐾")
                        .multilineTextAlignment(.leading)
                        .font(Font.custom("Quicksand-Medium", size: 17))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.secondary)
                    
                    Text("90 mins left!")
                        .font(Font.custom("Quicksand-Medium", size: 17))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.secondary)
                        .offset(x: -25)

                }
            }
        }
    }
}

struct ActivityCard_Previews: PreviewProvider {

    
    static var previews: some View {
        
        @State var progress: Float = 0.1
        
        ActivityCard(progress: $progress)
    }
}
