//
//  EditCard.swift
//  SD App V4
//
//  Created by Xaria Davis on 4/7/24.
//

import SwiftUI

struct SettingsCard: View {
    
    var iconImage: String
    var name: String
    
    var body: some View {
                    
        HStack(spacing: 20) {

            Image(systemName: iconImage)
                .font(.system(size: 20))
                            
            Text(name)
                .font(Font.custom("Quicksand-Semibold", size: 18))
            
            Spacer()
            
            Image(systemName: "chevron.right")
        }
        .padding(.horizontal, 20)
        .frame(minHeight: 70)
        .background(Color.fromNeuroKit)
      
    }
}

#Preview {
    SettingsCard(iconImage: "person", name: "Placeholder")
}
