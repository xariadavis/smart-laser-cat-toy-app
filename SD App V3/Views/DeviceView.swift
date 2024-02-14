//
//  DeviceView.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/12/24.
//

import SwiftUI

struct DeviceView: View {
    var body: some View {
        ZStack {
            
            //Color(.systemGray5).ignoresSafeArea()
            
            let gradient = RadialGradient(
                gradient: Gradient(colors: [Color.red, Color.red]),
                center: .center,
                startRadius: 0,
                endRadius: UIScreen.main.bounds.width / 2
            )
            
            Rectangle()
                .fill(gradient)
                .ignoresSafeArea()
                        
            LottiePlusView(name: Constants.Enclosure, loopMode: .loop)
                .scaleEffect(1.2)                
        }
    }
}

struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceView()
    }
}
