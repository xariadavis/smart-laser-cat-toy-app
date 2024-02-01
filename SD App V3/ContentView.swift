//
//  ContentView.swift
//  SD App V3
//
//  Created by Xaria Davis on 1/30/24.
//

import SwiftUI

struct ContentView: View {
    
    let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.midBlue.opacity(0.15), Color(.systemGray6), Color.white.opacity(0.2)]),
        startPoint: .top,
        endPoint: .bottom
    )

    @State private var isLoginActive = false
    @State private var isRegisterActive = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                gradient.ignoresSafeArea()
                
                VStack {
                    // Welcome label
                    Text("Welcome")
                        .font(Font.custom("TitanOne", size: 60))
                        .foregroundColor(.black)
                    
                    // Some type of catch phrase
                    Text("Insert catch phrase")
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .foregroundColor(.black.opacity(0.7))
                    
                    Spacer()
                }
                .padding(.top, 30)
                
                
                LottiePlusView(name: Constants.GingerHunt, loopMode: .loop)
                    .offset(y: -50)
                
                VStack {
                    
                    LottiePlusView(name: Constants.LaserDots, loopMode: .loop, animationSpeed: 2)
                        .frame(width: 125)
                        .offset(x: 50, y: 260)
                    
                    
                    NavigationLink(value: "Register") {
                        Text("Sign Up")
                            .font(Font.custom("Quicksand-SemiBold", size: 20))
                            .frame(maxWidth: .infinity)
                            .padding(15)
                            .foregroundColor(Color.primary)
                            .background(Color.red.opacity(0.9))
                            .cornerRadius(40)
                            
                            // Apply glowing border effect
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.red, lineWidth: 4)
                                    .glow()
                                    .shadow(color: Color.red.opacity(0.3), radius: 5)
                                    .shadow(color: Color.red.opacity(0.3), radius: 10)
                                    .shadow(color: Color.red.opacity(0.3), radius: 15)
                                    .shadow(color: Color.red.opacity(0.3), radius: 20)
                            )
                            .padding(.horizontal, 40)
                            .padding(.vertical, 10)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(value: "Login") {
                        Text("Login")
                            .font(Font.custom("Quicksand-SemiBold", size: 20))
                            .padding(15)
                            .foregroundColor(Color.primary)
                            .frame(maxWidth: .infinity) 
                            .contentShape(Rectangle())
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.red.opacity(0.9), lineWidth: 2)
                                    // Apply glow effect
                                    .shadow(color: Color.red.opacity(0.3), radius: 10, x: 0, y: 0)
                                    .shadow(color: Color.red.opacity(0.3), radius: 20, x: 0, y: 0)
                                    .shadow(color: Color.red.opacity(0.3), radius: 30, x: 0, y: 0)
                                    .shadow(color: Color.red.opacity(0.3), radius: 40, x: 0, y: 0)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 40)
                    
                    Spacer()
                    
                }
                .padding(.bottom, 25)
                .navigationDestination(for: String.self) { destination in
                    switch destination {
                    case "Register":
                        RegisterView()
                    case "Login":
                        LoginView()
                    case "Profile":
                        ProfileView()
                    default:
                        EmptyView()
                    }
                }
            }
        }
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: effect)
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = effect
    }
}

struct GlassmorphicButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.black.opacity(0.8))
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(
                ZStack {
                    VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
                    if configuration.isPressed {
                        Color.gray.opacity(0.2)
                    } else {
                        Color.white.opacity(0.2)
                    }
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white, lineWidth: 1)
                    .blendMode(.overlay)
                    .glow()
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
