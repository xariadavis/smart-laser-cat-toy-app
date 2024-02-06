//
//  ListCard.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/4/24.
//

import SwiftUI
import Neumorphic

struct ActivityCard2: View {
    
    @Binding var progress: Float
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .fill(Color.Neumorphic.main)
                .frame(width: 350, height: 200)
                .cornerRadius(20)
                .padding(.horizontal, 20)
            
            HStack() {
            
                ZStack(alignment: .center) {
                    Circle()
                        .stroke(lineWidth: 20)
                        .fill(Color.Neumorphic.main)
                        .softInnerShadow(
                            Circle(),
                            darkShadow: Color.Neumorphic.darkShadow,
                            lightShadow: Color.Neumorphic.lightShadow,
                            spread: 0.7,
                            radius: 10
                        )
                        .frame(width: 150, height: 150)

                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.red)
                        .rotationEffect(Angle(degrees: 270))
                        .animation(.easeInOut(duration: 2.0))
                        .frame(width: 150, height: 138)
                }
            
                
                VStack {
                    Text("Good Work!\nOther Words and stuff")
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}

struct ActivityCard2_Previews: PreviewProvider {

    
    static var previews: some View {
        @State var progress: Float = 0.3
        ActivityCard2(progress: $progress)
    }
}
