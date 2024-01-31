//
//  TestView.swift
//  SD App V3
//
//  Created by Xaria Davis on 1/30/24.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        ZStack {
            Color(.blue).ignoresSafeArea()
            
            // Square with glassmorphic effect
            Rectangle()
                .fill(Color.clear) // Make sure the rectangle is transparent
                .frame(width: 200, height: 200) // Square size
                .background(
                    VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialLight))
                )
                .cornerRadius(20) 
                .shadow(color: Color.red.opacity(0.3), radius: 10, x: 0, y: 0)
                .shadow(color: Color.red.opacity(0.3), radius: 20, x: 0, y: 0)
                .padding()
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
