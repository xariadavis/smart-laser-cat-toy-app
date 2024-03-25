//
//  LoadingView.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/24/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemGray5).ignoresSafeArea()
            LottiePlusView(name: Constants.Loading, loopMode: .loop)
        }
        
    }
}

#Preview {
    LoadingView()
}
