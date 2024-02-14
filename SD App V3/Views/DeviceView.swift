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
            
            Color(.systemGray5).ignoresSafeArea()
            
            let gradient = RadialGradient(
                gradient: Gradient(colors: [Color.red, Color.red]),
                center: .center,
                startRadius: 0,
                endRadius: UIScreen.main.bounds.width / 2
            )
            
            VStack(alignment: .leading) {
                
                // The red cover
                CurvedRectangle()
                    .fill(gradient)
                    .frame(height: 300)
                    .glow()
                    .overlay(
                        LottiePlusView(name: Constants.Enclosure, loopMode: .loop, animationSpeed: 0.3)
                        .scaleEffect(1.2)
                        .padding(.top, 50)
                    )
                
                Spacer()
                
                Text("My Device")
                    .font(Font.custom("TitanOne", size: 25))
                    .padding(10)
                
                Spacer()
                
            }
            .ignoresSafeArea()
        }
    }
}


struct CurvedRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.maxY), control: CGPoint(x: rect.midX, y: rect.maxY + 50))
        
        path.closeSubpath()
        
        return path
    }
}

struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceView()
    }
}
