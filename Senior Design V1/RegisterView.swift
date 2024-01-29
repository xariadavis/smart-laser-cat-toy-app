//
//  RegisterView.swift
//  Senior Design V1
//
//  Created by Xaria Davis on 1/28/24.
//

import SwiftUI

struct RegisterView: View {
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            Rectangle()
                .fill(Color.red)
                .opacity(0.65)
                .ignoresSafeArea()
                .glow()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
