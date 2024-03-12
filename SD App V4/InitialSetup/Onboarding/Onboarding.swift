//
//  Onboarding.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/11/24.
//

import SwiftUI

struct Onboarding: View {
    @ObservedObject private var sharedInfo = SharedRegistrationInfo.shared
        
    var body: some View {
        ZStack {
            
            Color(.systemGray5).ignoresSafeArea()
            
            Text("How old is \(String(describing: sharedInfo.catName))")
            
            
            VStack {
                Spacer()
                Button(action: {
                    print("1: catName is \(SharedRegistrationInfo.shared.catName)")
                }, label: {
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                })
            }
        }
    }
}

struct CatNameView: View {
    var body: some View {
        Text("How old is CATNAME")
    }
}

#Preview {
    Onboarding()
}
