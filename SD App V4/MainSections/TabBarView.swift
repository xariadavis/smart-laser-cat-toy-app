////
////  TabBarView.swift
////  SD App V4
////
////  Created by Xaria Davis on 3/9/24.
////
//
//import SwiftUI
//import AnimatedTabBar
//
//enum Tab: Int, CaseIterable {
//    case dashboard = 0, patterns, profile, settings
//}
//
//struct TabBarView: View {
//    @EnvironmentObject var navigationState: NavigationState
//    @State private var prevSelectedIndex: Tab = .dashboard
//
//    let icons = ["house", "circle.circle", "pawprint", "gearshape"]
//
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            Color(.systemGray5).ignoresSafeArea()
//            
//            selectedView
//            
//            AnimatedTabBar(selectedIndex: Binding(get: { self.navigationState.currentTab.rawValue }, set: { self.navigationState.currentTab = Tab(rawValue: $0)! }), prevSelectedIndex: Binding(get: { self.prevSelectedIndex.rawValue }, set: { self.prevSelectedIndex = Tab(rawValue: $0)! })) {
//                ForEach(Tab.allCases, id: \.self) { tab in
//                    colorButtonFor(tab: tab)
//                }
//            }
//            .configureBar()
//        }
//    }
//    
//    @ViewBuilder
//    private var selectedView: some View {
//        switch navigationState.currentTab {
//        case .dashboard:
//            DashboardView()
//        case .patterns:
//            PatternsView()
//        case .profile:
//            ProfileView()
//        case .settings:
//            SettingsView()
//        }
//    }
//
//    func colorButtonFor(tab: Tab) -> some View {
//        ColorButton(
//            image: Image(systemName: icons[tab.rawValue]),
//            colorImage: Image(systemName: icons[tab.rawValue]),
//            isSelected: navigationState.currentTab == tab,
//            fromLeft: prevSelectedIndex.rawValue < tab.rawValue,
//            toLeft: navigationState.currentTab.rawValue < tab.rawValue,
//            animationType: tab == .settings ? .gear : .bell
//        )
//    }
//}
//
//extension AnimatedTabBar {
//    func configureBar() -> some View {
//        self
//            // Ensure all custom colors and properties are correctly defined elsewhere in your project
//            .barColor(Color.fromNeuroKit)
//            .barBackgroundColor(Color(.systemGray6))
//            .cornerRadius(16)
//            .selectedColor(Color.green)
//            .unselectedColor(Color.yellow)
//            .ballColor(Color.red)
//            .verticalPadding(20)
//            .ballTrajectory(.straight)
//            .ballAnimation(.interpolatingSpring(stiffness: 130, damping: 15))
//            .indentAnimation(.easeOut(duration: 0.3))
//            .frame(height: 0)
//            .shadow(radius: 5)
//    }
//}
//
//#Preview {
//    TabBarView()
//}


//
//  TabBar.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/11/24.
//

import SwiftUI
import AnimatedTabBar

struct CircleValues {
    var scale = 1.0
    var offset = 1.3
}

struct TabBar: View {
    @Binding var selectedIndex: Int
    @State private var prevSelectedIndex = 0

    let names = ["house", "circle.circle", "pawprint", "gearshape"]

    // a hack for keyframe animation
    @State var time = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        
#if swift(>=5.9)
        if #available(iOS 17.0, *) {
            tabbars()
            // a hack for keyframe animation
                .onReceive(timer) { input in
                    time = Date().timeIntervalSince1970
                }
        }
#else
        tabbars()
#endif
    }

    
    func tabbars() -> some View {
        ZStack(alignment: .bottom) {
            Color(.systemGray5).ignoresSafeArea()
            
            Group {
                switch selectedIndex {
                case 0:
                    DashboardView()
                case 1:
                    PatternsView()
                case 2:
                    ProfileView()
                case 3:
                    SettingsView()
                default:
                    EmptyView() // Fallback view
                }
            }
//            .transition(.scale(scale: 0.9))
            
            AnimatedTabBar(selectedIndex: $selectedIndex, prevSelectedIndex: $prevSelectedIndex) {
                colorButtonAt(0, type: .bell)
                colorButtonAt(1, type: .bell)
                colorButtonAt(2, type: .bell)
                colorButtonAt(3, type: .gear)
            }
            .barColor(Color.fromNeuroKit)
            .barBackgroundColor(Color(.systemGray5))
            .cornerRadius(16)
            .selectedColor(.gray)
            .unselectedColor(Color.green)
            .ballColor(.red)
            .verticalPadding(20)
            .ballTrajectory(.straight)
            .ballAnimation(.interpolatingSpring(stiffness: 130, damping: 15))
            .indentAnimation(.easeOut(duration: 0.3))
            .frame(height: 0)
            .shadow(radius: 5)
        }
//        .animation(.easeInOut(duration: 0.3), value: selectedIndex)

    }
    
    func colorButtonAt(_ index: Int, type: ColorButton.AnimationType) -> some View {
        ColorButton(
            image: Image(systemName: names[index]),
            colorImage: (Image(systemName: names[index])),
//            colorImage: Image(systemName: "\(names[index]).fill"),
//            colorImage: Image(systemName: "\(names[index])"),
            isSelected: selectedIndex == index,
            fromLeft: prevSelectedIndex < index,
            toLeft: selectedIndex < index,
            animationType: type
        )
    }
}

//struct TabBar_Previews: PreviewProvider {
//
//    static var previews: some View {
//        State private var selectedIndex = 0
//        TabBar(selectedIndex: $selectedIndex)
//    }
//}
