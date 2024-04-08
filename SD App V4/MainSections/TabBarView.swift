//
//  TabBar.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/11/24.
//

import SwiftUI
import AnimatedTabBar
import Kingfisher

struct CircleValues {
    var scale = 1.0
    var offset = 1.3
}

struct TabBar: View {
    
    @Binding var selectedIndex: Int
    @State private var prevSelectedIndex = 0
    @State private var showingPatternDetail: Bool = false
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel

    let names = ["house", "circle.circle", "pawprint", "gearshape"]

    @State var time = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack(alignment: .bottom) {
            //VStack {
                Spacer()
    #if swift(>=5.9)
                if #available(iOS 17.0, *) {
                                            
                    tabbars()
                    // a hack for keyframe animation
                        .onReceive(timer) { input in
                            time = Date().timeIntervalSince1970
                        }
                        .zIndex(0)
                }
    #else
                tabbars()
    #endif
            }
            .sheet(isPresented: $showingPatternDetail) {
                if let pattern = timerViewModel.currentPattern {
                    PatternDetailCover(pattern: .constant(pattern), isConnected: bluetoothViewModel.isConnected, onDismiss: {
                        showingPatternDetail = false
                    })
                    .environmentObject(timerViewModel)
                }
            }
    }

    
    func tabbars() -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Color(.systemGray5).ignoresSafeArea()
                
                Group {
                    switch selectedIndex {
                    case 0:
                        DashboardView()
                    case 1:
                        PatternsView()
                    case 2:
                        ProfileView(viewModel: ProfileViewModel(firestoreManager: FirestoreManager()))
                    case 3:
                        SettingsView(viewModel: SettingsViewModel(authViewModel: AuthViewModel()))
                    default:
                        FallbackView() // Fallback view
                    }
                }
                //            .transition(.scale(scale: 0.9))
                VStack {
                    if timerViewModel.sessionActive, let pattern = timerViewModel.currentPattern {
                        nowPlayingBar(for: pattern)
                            .frame(width: geometry.size.width, height: 75)
                            .background(Color(.fromNeuroKit))
                            .cornerRadius(16)
                            .transition(.move(edge: .bottom).combined(with: .opacity)) // Smooth transition for appearing/disappearing
                            .padding(.bottom, 35)
                            .shadow(radius: 5)
                    }
                    
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
                    .shadow(radius: timerViewModel.sessionActive ? 0 : 5)
                }
                //        .animation(.easeInOut(duration: 0.3), value: selectedIndex)
            }
        }
    }
    
    func colorButtonAt(_ index: Int, type: ColorButton.AnimationType) -> some View {
        ColorButton(
            image: Image(systemName: names[index]),
            colorImage: (Image(systemName: names[index])),
            isSelected: selectedIndex == index,
            fromLeft: prevSelectedIndex < index,
            toLeft: selectedIndex < index,
            animationType: type
        )
    }
    
    private func nowPlayingBar(for pattern: LaserPattern) -> some View {
        Button(action: {
            showingPatternDetail = true
        }) {
            HStack {
                KFImage(URL(string: pattern.iconName))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30) // Adjust size as needed
                
                Text("Now Playing: \(pattern.name)")
                    .font(Font.custom("Quicksand-Bold", size: 17))
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                Spacer()
                
                Image(systemName: "chevron.up")
                    .padding(.trailing)
            }
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.bottom, 20)
        //.shadow(radius: 5)
    }
}

//struct TabBar_Previews: PreviewProvider {
//
//    static var previews: some View {
//        State private var selectedIndex = 0
//        TabBar(selectedIndex: $selectedIndex)
//    }
//}
