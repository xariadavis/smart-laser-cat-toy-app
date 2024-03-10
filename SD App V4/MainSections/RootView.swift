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
        
        VStack {
           // Content based on selected tab
           switch selectedTab {
           case 0:
               Text("Dashboard View")
           case 1:
               Text("Patterns List View")
           case 2:
               Text("Profile View")
           case 3:
               Text("Settings View")
           default:
               EmptyView()
           }

           Spacer()
           
           // Custom Tab Bar
            TabBar(selectedIndex: $selectedTab)
       }
        
    }
}

#Preview {
    RootView()
}
