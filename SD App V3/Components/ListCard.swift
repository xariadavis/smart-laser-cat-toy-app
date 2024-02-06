//
//  ListCard.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/4/24.
//

import SwiftUI

struct ListCard: View {
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.Neumorphic.main)
                .frame(width: 350, height: 100)
                .cornerRadius(20)
                .padding(.horizontal, 20)
        }
    }
}

struct ListCard_Previews: PreviewProvider {
    static var previews: some View {
        ListCard()
    }
}
