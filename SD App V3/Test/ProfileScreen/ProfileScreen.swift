//
//  ProfileScreen.swift
//  Example
//
//  Created by Danil Kristalev on 01.11.2021.
//  Copyright © 2021 Exyte. All rights reserved.
//

import SwiftUI
import ScalingHeaderScrollView

struct ProfileScreen: View {
    
    @ObservedObject private var viewModel = ProfileScreenViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State var progress: CGFloat = 0
    @State private var offset = CGSize.zero
    @State private var isEditMode = false
    
    private let minHeight = 110.0
    private let maxHeight = 500.0
    
    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()
            
            ScalingHeaderScrollView {
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                    largeHeader(progress: progress)
                }
                .padding(.bottom, 20)
            } content: {
                ScrollView {
                    ForEach(0..<10) { item in
                        PatternCard(iconName: "paperplane", name: "Pattern #\(item)", description: "Description for pattern \(item)")
                        
                    }
                    .padding(.top, 5)
                }
            }
            .height(min: minHeight, max: maxHeight)
            .collapseProgress($progress)
            .allowsHeaderGrowth()
        }
        .ignoresSafeArea()
    }
    
    
    private var smallHeader: some View {
        HStack(spacing: 12.0) {
            Image(viewModel.avatarImage)
                .resizable()
                .frame(width: 40.0, height: 40.0)
                .clipShape(RoundedRectangle(cornerRadius: 6.0))
            
            Text(viewModel.userName)
                .font(Font.custom("TitanOne", size: 20))
            
        }
    }
    
    private func largeHeader(progress: CGFloat) -> some View {
        ZStack {
            
            VStack {
                Image(viewModel.avatarImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: maxHeight)
                    .cornerRadius(20)
                    .opacity(1 - progress)
                    .offset(x: offset.width, y: offset.height) // Use the offset to adjust the position
                    .gesture(
                        isEditMode ?
                        DragGesture()
                            .onChanged { gesture in
                                self.offset = gesture.translation
                            }
                        : nil
                    )
                    .animation(.easeInOut, value: offset) // Animate the offset change
                
                Spacer()
            }
        
            
            VStack {
                Spacer()
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 40.0, style: .circular)
                        .foregroundColor(.clear)
                        .background(.white)
                    
                    userName
                        .padding(.leading, 20.0)
                        .opacity(1 - max(0, min(1, (progress - 0.75) * 4.0)))
                        .font(Font.custom("TitanOne", size: 20))
                        .foregroundColor(Color.primary)
                    
                    smallHeader
                        .padding(.leading, 85.0)
                        .opacity(progress)
                        .opacity(max(0, min(1, (progress - 0.75) * 4.0)))
                    
                    Button(action: {
                        // Toggle edit mode when button is clicked
                        self.isEditMode.toggle()
                    }) {
                        // Conditionally show ellipsis or checkmark based on isEditMode
                        Image(systemName: isEditMode ? "checkmark" : "ellipsis")
                            .font(.headline) // Adjust the size as needed
                            .foregroundColor(.primary) // Change the color if needed
                            .rotationEffect(.degrees(isEditMode ? 0 : 90))
                    }
                    .padding(.leading, 350)
                }
                .frame(height: 60.0)
            }
        }
    }
    
    
    private var userName: some View {
        Text(viewModel.userName)
        
    }
}





struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileScreen()
        }
    }
}
