//
//  RootView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/10/24.
//

import SwiftUI
import Kingfisher

struct RootView: View {
    
    @State var selectedTab: Int = 0
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var userCatsViewModel: UserCatsViewModel
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    @State private var showingPatternDetail = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Your main content here
            TabBar(selectedIndex: $selectedTab)
                .onAppear {
                    userCatsViewModel.loadUserData(id: sessionManager.currentUser?.id ?? "")
                }

            if timerViewModel.sessionActive, let pattern = timerViewModel.currentPattern {
                sessionActiveButton(for: pattern)
                    .padding() // Add padding to move the button from the very edge
                    .padding(.bottom, 50) // Additional padding to lift the button above the tab bar
            }
        }
    }

    private func sessionActiveButton(for pattern: LaserPattern) -> some View {
        Button(action: {
            showingPatternDetail = true
        }) {
            KFImage(URL(string: pattern.iconName))
                .resizable()
                .scaledToFill()
                .padding()
                .frame(width: 75, height: 75) // Adjust size as needed
                .background(Color.white) // Background color to make the image stand out
                .clipShape(Circle())
                .shadow(radius: 2) // Optional: adds a shadow for depth
                .overlay(Circle().stroke(Color.red, lineWidth: 1)) // Optional: adds a border
                .padding()
        }
        .sheet(isPresented: $showingPatternDetail) {
            PatternDetailCover(pattern: .constant(pattern)) {
                // onDismiss action to handle the cover dismissal
            }
            .environmentObject(timerViewModel)
        }
        .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to avoid button effects
        .fixedSize()
    }
}


#Preview {
    RootView()
}
