import SwiftUI

struct ProfileCard: View {
    
    let cardGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.5)])
    
    // Define the gradient for the "laser"
    let laserGradientColors = [Color.red.opacity(0.5), Color.red, Color.red.opacity(0.5)]
    
    // State for gradient animation
    @State private var gradientStart = UnitPoint(x: -0.5, y: -0.5)
    @State private var gradientEnd = UnitPoint(x: 0, y: 0)
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .frame(width: 350, height: 350)
                .shadow(radius: 7)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(LinearGradient(gradient: Gradient(colors: laserGradientColors), startPoint: gradientStart, endPoint: gradientEnd), lineWidth: 5)
                        .onAppear {
                            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                                // Move the gradient around
                                gradientStart = UnitPoint(x: 1.5, y: 1.5)
                                gradientEnd = UnitPoint(x: 2, y: 2)
                            }
                        }
                )
            
            Image("KittyProfilePic")
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            
            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: UnitPoint.bottom)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            
            VStack() {
                Spacer()
                Text("Sir Walter Honey Bee 🐝")
                    .font(Font.custom("TitanOne", size: 20))
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
            }
            .padding(20)
            
        }
        .frame(width: 350, height: 350)
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
