import SwiftUI

struct CustomProgressBar: View {
    @State var progressValue: Float = 0.0
    
    var body: some View {
        VStack {
            KittyProgressBar(progress: self.$progressValue)
                .frame(width: 20, height: 20)
                .rotationEffect(Angle.degrees(180))
                .padding(20.0)
                .onAppear() {
                    self.progressValue = 1.0
                }
        }
    }
}


struct KittyProgressBar_1: View {
    @Binding var progress: Float
    var color: Color = Color.green
    
    var body: some View {
        ZStack {
            KittyShape()
                .stroke(lineWidth: 20)
                .opacity(0.20)
                .foregroundColor(.gray)
            KittyShape()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                .foregroundStyle(RadialGradient(gradient: Gradient(colors: [.red, .pink]), center: .center, startRadius: 0, endRadius: 300))
                .animation(.easeIn(duration: 2.0))
        }
    }
}


struct CustomProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        
        CustomProgressBar()
    }
}
