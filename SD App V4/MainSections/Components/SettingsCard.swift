//
//  EditCard.swift
//  SD App V4
//
//  Created by Xaria Davis on 4/7/24.
//

import SwiftUI

struct SettingsCard: View {
    
    @EnvironmentObject var navigationState: NavigationState
    var iconImage: String
    var name: String
    
    var body: some View {
        HStack(spacing: 20) {

            Image(systemName: iconImage)
                .font(.system(size: 20))
                .frame(width: 20, alignment: .center)
                .foregroundColor(Color.primary)
                            
            Text(name)
                .font(Font.custom("Quicksand-Semibold", size: 18))
                .foregroundColor(Color.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(Color.primary)
        }
        .padding(.horizontal, 20)
        .frame(minHeight: 60)
        .background(Color.fromNeuroKit)
    }
}

#Preview {
    SettingsCard(iconImage: "person", name: "Placeholder")
}
