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
    var info: String
    var action: () -> Void
    
    var body: some View {
        
        Button {
            action()
        } label: {
            HStack(spacing: 20) {

                Image(systemName: iconImage)
                    .font(.system(size: 25))
                    .frame(width: 25, alignment: .center)
                    .foregroundColor(Color.primary)
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(Font.custom("Quicksand-Regular", size: 13))
                        .foregroundColor(Color.primary.opacity(0.7))
                    
                    Text(info)
                        .font(Font.custom("Quicksand-Semibold", size: 18))
                        .foregroundColor(Color.primary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.primary)
            }
            .padding(.horizontal, 20)
            .frame(minHeight: 70)
            .background(Color.fromNeuroKit)
        }

    }
}

#Preview {
    SettingsCard(iconImage: "person", name: "Placeholder", info: "Test", action: {})
}
