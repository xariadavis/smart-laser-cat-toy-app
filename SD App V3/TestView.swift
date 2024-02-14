import SwiftUI

struct LaserCapsuleProgressBar: View {
    var progress: CGFloat // Assume a value between 0.0 and 1.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // Background capsule
                Capsule()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .foregroundColor(.gray.opacity(0.2))
                
                // Foreground capsule with gradient
                Capsule()
                    .frame(width: geometry.size.width, height: geometry.size.height * progress)
                    .foregroundColor(.clear)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.red.opacity(0.6), .red]), startPoint: .top, endPoint: .bottom)
                    )
                    .animation(.linear, value: progress)
                
                // Laser effect
                if progress > 0 {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 2)
                        .foregroundColor(.white)
                        .offset(y: -geometry.size.height * (1 - progress))
                        .animation(.easeOut(duration: 0.2), value: progress)
                }
            }
        }
        .frame(height: 30) // Set the fixed height for the progress bar
    }
}

struct LaserCapsuleProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        LaserCapsuleProgressBar(progress: 0.5)
            .padding()
    }
}
