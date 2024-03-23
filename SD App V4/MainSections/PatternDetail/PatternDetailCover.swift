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
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var userCatsViewModel: UserCatsViewModel
    
    var onDismiss: () -> Void  // Closure for dismissing the view
    
    var body: some View {
        ZStack {
            
            Color(.systemGray5).ignoresSafeArea()
            
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
    
    func timerCard() -> some View {
        
        HStack {
            VStack {
                Spacer()
                
                Text("Remaining:")
                    .font(Font.custom("Quicksand-Bold", size: 20))
                    .onAppear {
                        print("Session active: \(timerViewModel.sessionActive)")
                        print("time remaining: \(timerViewModel.countdownTime)")
                        print("time remaining: \(userCatsViewModel.cat.timeRemaining)")
                    }
                
                Text("\(timerViewModel.formattedTime)")
                    .font(Font.custom("Quicksand-Bold", size: 25))
                    .onAppear {
                        
                        if !timerViewModel.sessionActive {
                            timerViewModel.countdownTime = TimeInterval(userCatsViewModel.cat.timeRemaining)
                        }
                        
                        timerViewModel.startSession()
                    }
                
                    
                // Stop button with SF Symbol
                Button(action: {
                    timerViewModel.endSession()
                    
                    userCatsViewModel.cat.timeRemaining = Int(timerViewModel.countdownTime)
                    userCatsViewModel.updateCatInfo(id: userCatsViewModel.user.id, catID: userCatsViewModel.cat.id ?? "", updates: ["timeRemaining" : Int(timerViewModel.countdownTime), "timePlayedToday":userCatsViewModel.cat.dailyQuota - Int(timerViewModel.countdownTime)])
                    
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
        PatternDetailCover(pattern: .constant(samplePattern), onDismiss: {
            
        })
    }
}
