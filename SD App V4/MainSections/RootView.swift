//
//  RootView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/10/24.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Int = 0
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var userCatsViewModel: UserCatsViewModel
    
    var body: some View {

       // Custom Tab Bar
        TabBar(selectedIndex: $selectedTab)
            .onAppear {
                userCatsViewModel.loadUserData(id: sessionManager.currentUser?.id ?? "")
                print("Root View: \(sessionManager.currentUser?.cat?.name)")
                print("Root View: \(userCatsViewModel.cat)")
            }
        
    }
}

#Preview {
    RootView()
}
