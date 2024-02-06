//
//  ListCard.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/4/24.
//

import SwiftUI
import Neumorphic

struct ActivityCard4: View {
    
    @Binding var progress: Float
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .fill(Color.Neumorphic.main)
                .frame(width: 350, height: 200)
                .cornerRadius(20)
                .padding(.horizontal, 20)
            
            HStack(spacing: 20) {
            
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemGray5))
                        .frame(width: 20, height:150)
                    
                    RoundedRectangle(cornerRadius: 20).fill(.red)
                        .frame(width: 20, height:100)
                }
                .offset(x: -20)
            
                
                VStack() {
                    Text("Good Work!\nOther Words and stuff")
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}

struct ActivityCard4_Previews: PreviewProvider {

    
    static var previews: some View {
        @State var progress: Float = 0.3
        ActivityCard4(progress: $progress)
    }
}
