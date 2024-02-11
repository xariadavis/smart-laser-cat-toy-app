//
//  TestView.swift
//  SD App V3
//
//  Created by Xaria Davis on 1/30/24.
//

import SwiftUI
import PZCircularControl
import AnimatedTabBar

struct TestView: View {
    var body: some View {
        ZStack {
            
            PZCircularControl(
                PZCircularControlParams(
                    innerBackgroundColor: Color.clear,
                    outerBackgroundColor: Color.gray.opacity(0.5),
                    tintColor: LinearGradient(gradient: Gradient(colors: [.myOrange, .myRed]), startPoint: .bottomLeading, endPoint: .topLeading),
                    textColor: .gray,
                    barWidth: 30.0,
                    glowDistance: 30.0,
                    initialValue: CGFloat(Float.random(in: 0...1))
                )
                
            )

        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
