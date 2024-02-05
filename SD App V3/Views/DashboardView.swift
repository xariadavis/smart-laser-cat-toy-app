//
//  DashboardView.swift
//  SD App V3
//
//  Created by Xaria Davis on 2/4/24.
//

import SwiftUI
import Neumorphic

struct DashboardView: View {
    var body: some View {
        ZStack(alignment: .center) {
            
            // Define background color
            Color(.systemGray6).ignoresSafeArea()
            
            VStack {
                // Image
                Image("KittyProfilePic") // Initialize Image with name
                    .resizable()
                    .scaledToFill() // Fill the ZStack, you can adjust this as needed
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.8) // Half the screen height
                    .clipped() // Ensure the image does not exceed its frame
                    .cornerRadius(20)
                
                Spacer()
            }
            
            // Overlay Content
            VStack {
                Spacer()
                
                Text("Walter Honeybee") // Dynamic name based on your struct
                    .font(Font.custom("TitanOne", size: 30))
                    .foregroundColor(.white)
                
                Spacer().frame(height: 450) // Adjust spacing at the bottom
            }
        }
        .edgesIgnoringSafeArea(.all) // Make the image cover the entire top half including the safe area
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
