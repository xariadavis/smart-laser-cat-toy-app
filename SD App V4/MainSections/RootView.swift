//
//  RootView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/10/24.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Int = 0
    
    var body: some View {

       // Custom Tab Bar
        TabBar(selectedIndex: $selectedTab)
        
    }
}

#Preview {
    RootView()
}
