//
//  Card.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/4/24.
//

import SwiftUI
import Neumorphic

struct Card: View {
    var body: some View {
            
        RoundedRectangle(cornerRadius: 30)
            .fill(Color.white)
            .shadow(radius: 7)
            .glow()
            .frame(width: 350, height: 300)
            

    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card()
            .previewLayout(.sizeThatFits)
    }
}
