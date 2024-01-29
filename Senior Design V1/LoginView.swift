// Doubt this is the final design

import SwiftUI

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var opacity = 0.0

    var body: some View {
        ZStack {
            
            Color("Background").ignoresSafeArea()
            
            VStack {

//                GeometryReader { geometry in
//
//                    let height = geometry.size.height
//                    let width = geometry.size.width
//
//                    Circle()
//                        .fill(Color.red)
//                        .opacity(0.65)
//                        .frame(width: width * 2, height: height * 2)
//                        .position(x: width, y: 0)
//                        .glow()
//                }
                
                LottiePlusView(name: Constants.laserStars,
                               loopMode: .loop).ignoresSafeArea()
                    .frame(width: 425)

                
                Spacer()
                
                Text("Welcome Back")
                    .foregroundColor(.white)
                    .font(Font.custom("TitanOne", size: 60))
                    .bold()
                    .padding(.bottom, 30)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1)) {
                            opacity = 1.0
                        }
                    }
                
                TextField("Username", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                
                // Make this a link
                Text("Forgot Password?")
                    .padding(.top, 10)
                    .foregroundColor(.white)
                    .font(Font.custom("Quicksand-Bold", size: 17))
                
                Spacer()
                
                Button("Sign in") {
                    print("Go to profile")
                }
                .font(Font.custom("Quicksand-Bold", size: 20))
                .frame(maxWidth: .infinity)
                .padding()
                .background(.red.opacity(0.65))
                .foregroundColor(.white)
                .cornerRadius(40)
                .padding(.horizontal, 60)
                
                
                // Make this a link
                Text("New here? Sign Up")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .font(Font.custom("Quicksand-SemiBold", size: 17))
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
