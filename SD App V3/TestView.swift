import SwiftUI

struct LightSaberButton: View {
    @State private var saberActivated = false

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.5)) {
                saberActivated.toggle()
            }
        }) {
            VStack {
                if saberActivated {
                    // Light Saber Blade
                    Capsule()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.blue]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 10, height: 100) // Adjust size to your liking
                        .transition(.slide)
                        .animation(.easeInOut(duration: 0.5), value: saberActivated)
                }
                // Light Saber Handle
                Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .top, endPoint: .bottom))
                    .frame(width: 20, height: 30) // Adjust size to match your design
            }
            .frame(width: 20, height: saberActivated ? 130 : 30) // Adjust for total size
        }
        .padding()
        .background(Color.clear)
        .cornerRadius(10)
    }
}



struct CustomProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        
        LightSaberButton()
    }
}
