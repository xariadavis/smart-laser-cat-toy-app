//
//  SettingsView.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/12/24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color(.systemGray5).ignoresSafeArea()
            
            VStack {
                
                // Title
                Text("Settings")
                    .font(Font.custom("TitanOne", size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)  // Align text to the leading edge
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                
                Spacer()
                
                
                Button {
                    Task {
                        authViewModel.signOut()
                    }
                } label: {
                    Text("Log out")
                        .font(Font.custom("Quicksand-SemiBold", size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .foregroundColor(Color.primary)
                        .background(Color.red.opacity(0.9))
                        .cornerRadius(30)
                        .padding(.horizontal, 40)
                }

            }
            .padding(.bottom, 85)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
