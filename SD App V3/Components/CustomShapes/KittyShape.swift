//
//  KittyShape.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/16/24.
//

import SwiftUI

struct KittyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.78909*width, y: 9.87455*height))
        path.addCurve(to: CGPoint(x: 0.27455*width, y: 8.84*height), control1: CGPoint(x: 0.60364*width, y: 9.78909*height), control2: CGPoint(x: 0.37091*width, y: 9.32*height))
        path.addCurve(to: CGPoint(x: 0.19455*width, y: 7.94545*height), control1: CGPoint(x: 0.21091*width, y: 8.53273*height), control2: CGPoint(x: 0.19455*width, y: 8.34727*height))
        path.addCurve(to: CGPoint(x: 0.42909*width, y: 6.08545*height), control1: CGPoint(x: 0.19455*width, y: 7.35636*height), control2: CGPoint(x: 0.26909*width, y: 6.76545*height))
        path.addLine(to: CGPoint(x: 0.49818*width, y: 5.79818*height))
        path.addLine(to: CGPoint(x: 0.45636*width, y: 5.70364*height))
        path.addCurve(to: CGPoint(x: 0.16909*width, y: 4.73636*height), control1: CGPoint(x: 0.32545*width, y: 5.40364*height), control2: CGPoint(x: 0.22*width, y: 5.04909*height))
        path.addCurve(to: CGPoint(x: 0.16182*width, y: 3.74545*height), control1: CGPoint(x: 0.13273*width, y: 4.50909*height), control2: CGPoint(x: 0.12909*width, y: 3.98182*height))
        path.addCurve(to: CGPoint(x: 3.44364*width, y: 0.30909*height), control1: CGPoint(x: 0.38*width, y: 2.15636*height), control2: CGPoint(x: 1.65636*width, y: 0.82182*height))
        path.addCurve(to: CGPoint(x: 8.37273*width, y: 1.24182*height), control1: CGPoint(x: 5.15273*width, y: -0.18182*height), control2: CGPoint(x: 7.05818*width, y: 0.17818*height))
        path.addCurve(to: CGPoint(x: 9.76182*width, y: 3.36364*height), control1: CGPoint(x: 9.06727*width, y: 1.80364*height), control2: CGPoint(x: 9.56909*width, y: 2.56909*height))
        path.addCurve(to: CGPoint(x: 9.86*width, y: 4.22727*height), control1: CGPoint(x: 9.84182*width, y: 3.69636*height), control2: CGPoint(x: 9.86*width, y: 3.86182*height))
        path.addCurve(to: CGPoint(x: 9.58*width, y: 5.61091*height), control1: CGPoint(x: 9.86*width, y: 4.72727*height), control2: CGPoint(x: 9.77091*width, y: 5.16182*height))
        path.addCurve(to: CGPoint(x: 9.52364*width, y: 5.88*height), control1: CGPoint(x: 9.50545*width, y: 5.78182*height), control2: CGPoint(x: 9.50364*width, y: 5.79273*height))
        path.addCurve(to: CGPoint(x: 9.71636*width, y: 6.84545*height), control1: CGPoint(x: 9.64364*width, y: 6.42364*height), control2: CGPoint(x: 9.67818*width, y: 6.59455*height))
        path.addCurve(to: CGPoint(x: 9.69818*width, y: 8.96364*height), control1: CGPoint(x: 9.84182*width, y: 7.65636*height), control2: CGPoint(x: 9.83636*width, y: 8.42*height))
        path.addCurve(to: CGPoint(x: 9.23455*width, y: 9.86545*height), control1: CGPoint(x: 9.59273*width, y: 9.37636*height), control2: CGPoint(x: 9.38182*width, y: 9.78909*height))
        path.addCurve(to: CGPoint(x: 8.36909*width, y: 9.58*height), control1: CGPoint(x: 9.03273*width, y: 9.96909*height), control2: CGPoint(x: 8.78545*width, y: 9.88727*height))
        path.addCurve(to: CGPoint(x: 6.89091*width, y: 8.14*height), control1: CGPoint(x: 7.94545*width, y: 9.26727*height), control2: CGPoint(x: 7.16909*width, y: 8.51091*height))
        path.addCurve(to: CGPoint(x: 6.8*width, y: 8.05455*height), control1: CGPoint(x: 6.85636*width, y: 8.09455*height), control2: CGPoint(x: 6.81455*width, y: 8.05636*height))
        path.addCurve(to: CGPoint(x: 6.6*width, y: 8.10909*height), control1: CGPoint(x: 6.78545*width, y: 8.05455*height), control2: CGPoint(x: 6.69455*width, y: 8.08*height))
        path.addCurve(to: CGPoint(x: 4.66909*width, y: 8.32909*height), control1: CGPoint(x: 6.06182*width, y: 8.28*height), control2: CGPoint(x: 5.27455*width, y: 8.36909*height))
        path.addCurve(to: CGPoint(x: 3.45091*width, y: 8.12364*height), control1: CGPoint(x: 4.20182*width, y: 8.29818*height), control2: CGPoint(x: 3.88*width, y: 8.24364*height))
        path.addLine(to: CGPoint(x: 3.18182*width, y: 8.04909*height))
        path.addLine(to: CGPoint(x: 3.14182*width, y: 8.10182*height))
        path.addCurve(to: CGPoint(x: 1.99636*width, y: 9.28364*height), control1: CGPoint(x: 2.90364*width, y: 8.40545*height), control2: CGPoint(x: 2.35091*width, y: 8.97636*height))
        path.addCurve(to: CGPoint(x: 0.78909*width, y: 9.87455*height), control1: CGPoint(x: 1.39273*width, y: 9.80545*height), control2: CGPoint(x: 1.02364*width, y: 9.98545*height))
        path.closeSubpath()
        return path
    }
}

struct KittyShape_Previews: PreviewProvider {
    static var previews: some View {
        KittyShape()
            .frame(width: 15, height: 15)
            .rotationEffect(Angle(degrees: 180))
            .foregroundColor(Color.red)
    }
}
