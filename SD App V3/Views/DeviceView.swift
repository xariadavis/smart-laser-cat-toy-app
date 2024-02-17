//
//  DeviceView.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/12/24.
//

import SwiftUI
import PZCircularControl

struct DeviceView: View {
    var body: some View {
        ZStack {
            
            Color(.systemGray5).ignoresSafeArea()
            
            
            VStack {
                
                Text("My Device")
                Text("Connected")
                
                BatteryProgress()
                    .padding(.horizontal, 75)
                
                Spacer()
                
                
            }
                
                
                // If not active
                    // Last Played Text
                    
                    // Start playing button
                
                // Else
                    // Card with uptime
                
            
        }
    }
}

struct BatteryProgress: View {
    var body: some View {
        PZCircularControl(
            PZCircularControlParams(
                innerBackgroundColor: Color.clear,
                outerBackgroundColor: Color.Neumorphic.main,
                tintColor: LinearGradient(gradient: Gradient(colors: [.red, .pink]), startPoint: .topLeading, endPoint: .bottomTrailing),
                barWidth: 18.0,
                glowDistance: 10.0,
                font: Font.custom("Quicksand-Regular", size: 30),
                initialValue: CGFloat(Float.random(in: 0...1))
            )
        )
    }
}

struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceView()
    }
}
