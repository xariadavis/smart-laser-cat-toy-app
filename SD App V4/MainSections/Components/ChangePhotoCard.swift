//
//  ChangePhotoCard.swift
//  SD App V4
//
//  Created by Xaria Davis on 4/10/24.
//

import SwiftUI

struct ChangePhotoCard: View {

    var action: () -> Void
    
    var body: some View {
        
        Button {
            action()
        } label: {
            HStack(spacing: 20) {

                Image(systemName: "photo")
                    .font(.system(size: 25))
                    .frame(width: 25, alignment: .center)
                    .foregroundColor(Color.primary)
                
                Text("Change Profile Picture")
                    .font(Font.custom("Quicksand-Semibold", size: 18))
                    .foregroundColor(Color.primary)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .frame(minHeight: 70)
            .background(Color.fromNeuroKit)
        }

    }
}

#Preview {
    ChangePhotoCard(action: {})
}
