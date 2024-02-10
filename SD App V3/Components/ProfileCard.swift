import SwiftUI

struct ProfileCard: View {
    
    let cardGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.5)])
    
    // Define the gradient for the "laser"
    let laserGradientColors = [Color.red.opacity(0.5), Color.myRed, Color.red.opacity(0.5)]
    
    // State for gradient animation
    @State private var gradientStart = UnitPoint(x: -0.5, y: -0.5)
    @State private var gradientEnd = UnitPoint(x: 0, y: 0)
    
    let maxWidth = 330.0
    let maxHeight = 450.0
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: maxWidth, height: maxHeight)
                .shadow(radius: 7)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(LinearGradient(gradient: Gradient(colors: laserGradientColors), startPoint: gradientStart, endPoint: gradientEnd), lineWidth: 10)
                        .onAppear {
                            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: true)) {
                                // Move the gradient around
                                gradientStart = UnitPoint(x: 1.5, y: 1.5)
                                gradientEnd = UnitPoint(x: 2, y: 2)
                            }
                        }
                )
            
            Image("KittyProfilePic")
                .resizable()
                .scaledToFill()
                .frame(width: maxWidth, height: maxHeight)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: UnitPoint.bottom)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack() {
                Spacer()
                Text("Sir Walter Honey Bee 🐝")
                    .font(Font.custom("QuickSand-Bold", size: 20))
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
            }
            .padding(20)
            
        }
        .frame(width: maxWidth, height: maxHeight)
//        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(5)
    }
}

struct ProfileCard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCard()
            .previewLayout(.sizeThatFits)
    }
}
