//
//  ProfileView.swift
//  SD App V3
//
//  Created by Xaria Davis on 1/31/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack(alignment: .center) {
            
            // Define background color
            Color(.systemGray5).ignoresSafeArea()
            
            ScrollView {
                VStack {
                    // Image
                    Image("KittyProfilePic") // Initialize Image with name
                        .resizable()
                        .scaledToFill() // Fill the ZStack, you can adjust this as needed
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2) // Half the screen height
                        .clipped() // Ensure the image does not exceed its frame
                    
                    
                    // Spacer()
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading) {
                            // Kitty's name
                            Text("Sir Walter Honey Bee 🐝")
                                .font(Font.custom("TitanOne", size: 25))
                                .padding(10)
                            
                            HStack {
                                InfoCard(iconName: "clock", title: "Age", detail: "2 years")
                                InfoCard(iconName: "pawprint", title: "Breed", detail: "DMH")
                            }
                            HStack {
                                InfoCard(iconName: "person", title: "Sex", detail: "Male")
                                InfoCard(iconName: "scalemass", title: "Weight", detail: "15 lb")
                            }
                            
                            
                            Text("Favorites")
                                .font(Font.custom("TitanOne", size: 23))
                                .padding(.top, 20)
                            CarouselView()
                            
                            Text("Activity")
                                .font(Font.custom("TitanOne", size: 23))
                                .padding(.top, 20)
                            
                            // Maybe put activity card before this one
                            ActivityCard()
                            
                            VStack {
                                // Total calculated playtime this week
                                Text("Total Playtime")
                                    .font(Font.custom("Quicksand-Semibold", size: 17))
                                    .foregroundColor(.secondary)
                                
                                Text("2h 45m")
                                    .font(Font.custom("Quicksand-Semibold", size: 18))
                                    .fontWeight(.bold)
                                    .padding(.bottom, 20)
                                
                                HStack(alignment: .center, spacing: 10) {
                                    Spacer()
                                    BarView(value: 35, day: "M")
                                    BarView(value: 20, day: "T")
                                    BarView(value: 114, day: "W")
                                    BarView(value: 30, day: "Th")
                                    BarView(value: 55, day: "F")
                                    BarView(value: 100, day: "Sa")
                                    BarView(value: 120, day: "Su")
                                    Spacer()
                                }
                            }
                            .padding(.vertical, 30)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main))
                            
                            // Last Play Session
                            
                            
                            
                            
                        }
                        .padding()
                        
                    }
                    .background(Rounded().fill(Color(.systemGray5)))
                    .padding(.top, -50)
                    
                    Spacer()
                    
                }
                .padding(.bottom, 95)
                
            }
            .ignoresSafeArea()
        }
    }
}


struct InfoCard: View {
    var iconName: String
    var title: String
    var detail: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.red)
                .frame(width: 35, height: 35)
                .background(Color(.systemGray5))
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(title)
                    .font(Font.custom("Quicksand-Semibold", size: 15))
                    .foregroundColor(.secondary)
                Text(detail)
                    .font(Font.custom("Quicksand-Semibold", size: 16))
                    .fontWeight(.bold)
            }
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main))
        .frame(maxWidth: .infinity)
    }
    
}


struct Rounded: Shape {
    
    func path(in rect: CGRect) -> Path {
    
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
}


struct CarouselView: View {
    // This array holds the data which you want to display in your carousel.

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(laserPatterns.prefix(4)) { pattern in
                    CarouselItemView(pattern: pattern)
                        .frame(width: 150, height: 150)
                        .background(Color.Neumorphic.main)
                        .cornerRadius(12)
                }
            }
        }
    }
}

struct CarouselItemView: View {
    let pattern: LaserPattern

    var body: some View {
        VStack {
            Image(pattern.iconName)
                .resizable()
                .scaledToFill()
                .frame(width: 75, height: 75)
                .clipped()
                .cornerRadius(10)
                .padding(5)
            
            Text(pattern.name)
                .font(Font.custom("Quicksand-Semibold", size: 15))
                .padding(.horizontal, 5)
        }
    }
}


struct BarView: View {
    
    var value: CGFloat
    var day: String
    let progress = 0
    
    var body: some View {
        
        VStack {
            ZStack(alignment: .bottom) {
                Capsule()
                    .frame(width: 20, height: 150)
                    .foregroundColor(Color.red.opacity(0.2))
                
                Capsule()
                    .frame(width: 20, height: value)
                    .foregroundColor(Color.red)
            }
            
            Text(day)
                .font(Font.custom("Quicksand-Regular", size: 16))
                .frame(width: 35, alignment: .center) // Fix the width of the label
            
            Text("\(Int(((value / 150) * 100)))m")
                .font(Font.custom("Quicksand-Regular", size: 14))
                .foregroundColor(.secondary)
        }
        
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
