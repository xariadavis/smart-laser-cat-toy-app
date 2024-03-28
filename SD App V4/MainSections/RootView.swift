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
//    @EnvironmentObject var userCatsViewModel: UserCatsViewModel
    @EnvironmentObject var timerViewModel: TimerViewModel
    @State private var showingPatternDetail = false
    @ObservedObject var userCatsViewModel = UserCatsViewModel.shared
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                
                // Custom Tab Bar
                TabBar(selectedIndex: $selectedTab)
                    .onAppear {
                        print("In root view id: \(sessionManager.currentUser?.id)")
                        //userCatsViewModel.loadUserData(id: sessionManager.currentUser?.id ?? "")
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
}




#Preview {
    RootView()
}
