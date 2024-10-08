//
//  DashboardView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/8/24.
//

import SwiftUI
import PopupView

struct DashboardView: View {
    
    @EnvironmentObject var navigationState: NavigationState
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel
    
    @ObservedObject var patternsManager = PatternsManager.shared
    @ObservedObject var userCatsViewModel = UserCatsViewModel.shared
    
    @State private var selectedPattern: LaserPattern?
    @State private var showingPatternDetail = false
    
    var body: some View {

        ZStack {
            
            Color(.systemGray5).ignoresSafeArea()
  
            VStack {
                
                VStack {
                    Text("Dashboard")
                        .font(Font.custom("TitanOne", size: 30))
                        .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                        .padding(.horizontal, 30)
                        .padding(.top, 10)
                }
                
                ScrollView {
                    VStack {
                        
                        ProfileCard()
                            .padding(.bottom, 15)
                        
                        // Activity Card Title aligned to the left
                        Text("Activity")
                            .font(Font.custom("TitanOne", size: 25))
                            .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                            .padding(.horizontal, 30)
                        
                        ActivityCard()
                            .padding(.horizontal, 20)
                            .padding(.bottom, 15)
                        
                        
                        // Patterns Title aligned to the left
                        Text("Favorites")
                            .font(Font.custom("TitanOne", size: 25))
                            .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                            .padding(.horizontal, 30)
                        

                        Group {
                            if patternsManager.patterns.filter({ $0.isFavorite }).isEmpty {
                                Text("No favorites found. Double tap a pattern to add it to Favorites!")
                                    .font(Font.custom("Quicksand-Bold", size: 18))
                                    .multilineTextAlignment(.center) // Center-align the text
                                    .padding(50)
                            } else {
                                ForEach(patternsManager.patterns.filter { $0.isFavorite }) { pattern in
                                    PatternCard(pattern: pattern, userId: userCatsViewModel.user.id, catId: userCatsViewModel.cat.id ?? "")
                                }
                            }
                        }

//                        Button(action: {
//                            navigationState.path.append(MainNavigation.patternsList)
//                        }, label: {
//                            HStack {
//                                Text("See more")
//                                Image(systemName: "arrow.right")
//                            }
//                            .font(Font.custom("Quicksand-SemiBold", size: 17))
//                            .frame(maxWidth: .infinity)
//                            .padding(15)
//                            .foregroundColor(Color.primary)
//                            .background(Color.red.opacity(0.0))
//                            .cornerRadius(15)
//                            .padding(.horizontal, 15)
//                        })
                    }
                    
                    .padding(.bottom, timerViewModel.sessionActive ? 150 : 85)
                }
            }
        }
        .onAppear {
            bluetoothViewModel.readColorValue()
            print(bluetoothViewModel.currentColor)
        }
        .sheet(isPresented: $timerViewModel.showingPatternCover, onDismiss: {
            if bluetoothViewModel.isSearching {
                bluetoothViewModel.stopScanning()
            }
        }) {
            if let pattern = timerViewModel.currentPattern {
                PatternDetailCover(pattern: .constant(pattern), isConnected: bluetoothViewModel.isConnected) {
                    timerViewModel.showingPatternCover = false
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
