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
    @State private var selectedIndex = 0
    @State private var prevSelectedIndex = 0

    let names = ["house", "text.justify", "macpro.gen2", "pawprint", "gearshape"]

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
                    DeviceView()
                case 3:
                    ProfileView()
                case 4:
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
                colorButtonAt(3, type: .bell)
                colorButtonAt(4, type: .gear)
            }
            .barColor(Color.Neumorphic.main)
            .barBackgroundColor(Color(.systemGray5))
            .cornerRadius(16)
            .selectedColor(.exampleGrey)
            .unselectedColor(.exampleLightGrey)
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
            colorImage: Image("colorTab\(index+1)Bg"),
            isSelected: selectedIndex == index,
            fromLeft: prevSelectedIndex < index,
            toLeft: selectedIndex < index,
            animationType: type
        )
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
