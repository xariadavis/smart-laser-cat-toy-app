//
//  SplashScreen.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/27/24.
//

import SwiftUI

struct SplashScreen: View {
    
    var body: some View {
        ZStack {
            
            Color(.systemGray6).ignoresSafeArea()

            Image("Icon")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
        }
    }
}

#Preview {
    SplashScreen()
}
