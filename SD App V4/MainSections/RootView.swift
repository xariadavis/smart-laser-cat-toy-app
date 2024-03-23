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
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                
                // Custom Tab Bar
                TabBar(selectedIndex: $selectedTab)
                    .onAppear {
                        userCatsViewModel.loadUserData(id: sessionManager.currentUser?.id ?? "")
                    }
                
                if timerViewModel.sessionActive, let pattern = timerViewModel.currentPattern {
                    nowPlayingBar(for: pattern)
                        .frame(width: geometry.size.width, height: 70)
                        .background(Color.fromNeuroKit)
                        .cornerRadius(16)
                        .transition(.move(edge: .bottom).combined(with: .opacity)) // Smooth transition for appearing/disappearing
                        .padding(.bottom, 60)
                }
            }
        }
        .sheet(isPresented: $showingPatternDetail) {
            if let pattern = timerViewModel.currentPattern {
                PatternDetailCover(pattern: .constant(pattern), onDismiss: {
                    showingPatternDetail = false
                })
                .environmentObject(timerViewModel)
            }
        }
    }
    
    private func nowPlayingBar(for pattern: LaserPattern) -> some View {
        Button(action: {
            showingPatternDetail = true
        }) {
            HStack {
                KFImage(URL(string: pattern.iconName))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50) // Adjust size as needed
                    .clipShape(Circle())
                
                Text("Now Playing: \(pattern.name)")
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()
                
                Image(systemName: "chevron.up")
                    .padding(.trailing)
            }
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
    }
}




#Preview {
    RootView()
}
