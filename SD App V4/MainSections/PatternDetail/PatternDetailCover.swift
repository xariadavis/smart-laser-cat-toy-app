//
//  MiniPlayerView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/18/24.
//

import SwiftUI
import PopupView
import Kingfisher

struct PatternDetailCover: View {
    
    @Binding var pattern: LaserPattern?
    @State var isConnected: Bool
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel
    @ObservedObject var userCatsViewModel = UserCatsViewModel.shared
    @State private var showingBluetoothCard = false
        
    var onDismiss: () -> Void  // Closure for dismissing the view
    
    var body: some View {
        ZStack {
            
            Color(.systemGray5).ignoresSafeArea()
            
            if isConnected {
                detailOfPatternPlaying
            } else {
                needToConnect
            }
            
        }
        .onAppear {
            isConnected = bluetoothViewModel.isConnected
        }
        .onChange(of: bluetoothViewModel.isReady, {
            showingBluetoothCard = false
            isConnected = true
            bluetoothViewModel.writeOmegaValues(omega1: Int32(pattern!.omega_1), omega2: Int32(pattern!.omega_2))
        })
    }
    
    private var detailOfPatternPlaying: some View {
        Group {
            VStack {
                
                Text("NOW PLAYING")
                    .font(Font.custom("TitanOne", size: 25))
                    .padding(25)
                
                Spacer()
                // Header (Name)
                Text("\(pattern?.name ?? "")")
                    .font(Font.custom("Quicksand-Bold", size: 40))
                
                // Pattern Picture
                KFImage(URL(string: pattern?.iconName ?? ""))
                    .placeholder {
                        LottiePlusView(name: Constants.LaserLoading, loopMode: .loop)
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 225, height: 225)
                    .clipped()
                    .cornerRadius(10)
                    .padding(.vertical, 40)
                
                // Uptime
                timerCard()
                    .cornerRadius(20)
                    .padding()
                    
                Spacer()
            }
        }
    }
    
    private var needToConnect: some View {
        Group {
            
            VStack(alignment: .center) {
                
                Text("To play a pattern, please connect to the device.")
                    .font(Font.custom("Quicksand-Bold", size: 25))
                
                if showingBluetoothCard {
                    
                    SearchingView(onDismiss: onDismiss)
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                    
                } else {
                
                    Button {
                        bluetoothViewModel.isSearching = true
                        showingBluetoothCard = true
                    } label: {
                        Text("Pair")
                            .redButton()
                            .padding(.horizontal)
                    }
                
                }
                
                Button {
                    onDismiss()
                    bluetoothViewModel.stopScanning()
                } label: {
                    Text("Cancel")
                        .redOutlineButton()
                        .padding(.horizontal)
                }
            }
        }
    }
    
    func timerCard() -> some View {
        
        HStack {
            VStack {
                Spacer()
                
                Text("Remaining:")
                    .font(Font.custom("Quicksand-Bold", size: 20))
                
                Text("\(timerViewModel.formattedTime)")
                    .font(Font.custom("Quicksand-Bold", size: 25))
                    .onAppear {
                        timerViewModel.currentPattern = pattern
                        
                        if !timerViewModel.sessionActive {
                            timerViewModel.countdownTime = TimeInterval(userCatsViewModel.cat.timeRemaining)
                        }
                        
                        timerViewModel.startSession()
                    }
                
                    
                // Stop button with SF Symbol
                Button(action: {
                    timerViewModel.endSession()
                    
                    userCatsViewModel.cat.timeRemaining = Int(timerViewModel.countdownTime)
                    userCatsViewModel.cat.timePlayedToday = userCatsViewModel.cat.dailyQuota - Int(timerViewModel.countdownTime)
                    userCatsViewModel.updateCatInfo(id: userCatsViewModel.user.id, catID: userCatsViewModel.cat.id ?? "", updates: ["timeRemaining" : Int(timerViewModel.countdownTime), "timePlayedToday":userCatsViewModel.cat.dailyQuota - Int(timerViewModel.countdownTime)])
                    
                    bluetoothViewModel.writeOmegaValues(omega1: 90, omega2: 90)
                    
                    print("Time remaining: \(userCatsViewModel.cat.timeRemaining)")
                    onDismiss()  // Call the dismiss action
                    
                }) {
                    HStack {
                        Image(systemName: "stop.fill")
                        Text("End Session")
                            .font(Font.custom("Quicksand-Medium", size: 18))
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding(.vertical, 50)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 175)
        .background(Color(.systemGray4))
    }
    
}

struct PatternDetailCover_Previews: PreviewProvider {
    static let samplePattern = LaserPattern(id: "1", name: "Sample Pattern", description: "This is a sample pattern.", iconName: "BloomArray", isFavorite: false, omega_1: 1, omega_2: 1)
    
    static var previews: some View {
        PatternDetailCover(pattern: .constant(samplePattern), isConnected: true, onDismiss: {
            
        })
    }
}
