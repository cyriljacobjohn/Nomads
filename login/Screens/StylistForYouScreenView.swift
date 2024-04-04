//
//  ForYouScreenView.swift
//  UMI
//
//  Created by Cyril John on 3/30/24.
//

import Foundation
import SwiftUI

struct Stylist: Identifiable {
       var id = UUID()
       var name: String
       var distance: Double // in miles or kilometers
       var profileImageUrl: String
       var matchingPercentage: Float // e.g., 95
       var rating: Float
}

struct StylistForYouScreenView: View {
    
    @State private var progress: CGFloat = 0.0
    @State private var favoriteStylists: [UUID] = []
    
    let stylists: [Stylist] = [
        Stylist(id: UUID(), name: "Alex Smith", distance: 1.2, profileImageUrl: "https://example.com/image1.jpg", matchingPercentage: 90, rating: 2.6),
        Stylist(id: UUID(), name: "Jordan Doe", distance: 3.4, profileImageUrl: "https://example.com/image2.jpg", matchingPercentage: 85,rating: 4.6),
        
    ]

    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(stylists) { Stylist in
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(Stylist.name)
                                    .font(.custom("Poppins-SemiBold", size: 25))
                                    .foregroundColor(Color("PrimaryColor"))
                                
                                ZStack(alignment: .bottomTrailing) {
                                                                AsyncImage(url: URL(string: Stylist.profileImageUrl)) { image in
                                                                    image.resizable()
                                                                } placeholder: {
                                                                    Rectangle()
                                                                        .fill(Color.gray.opacity(0.3))
                                                                }
                                                                .aspectRatio(1, contentMode: .fit)
                                                                
                                                                Button(action: {
                                                                    if favoriteStylists.contains(Stylist.id) {
                                                                        favoriteStylists.removeAll { $0 == Stylist.id }
                                                                    } else {
                                                                        favoriteStylists.append(Stylist.id)
                                                                    }
                                                                }) {
                                                                    Image(systemName: favoriteStylists.contains(Stylist.id) ? "heart.fill" : "heart")
                                                                        .font(.system(size: 30))
                                                                        .foregroundColor(favoriteStylists.contains(Stylist.id) ? Color.indigo : .purple)
                                                                        .padding(10)
                                                                        .background(Color.white.opacity(0.5))
                                                                        .clipShape(Circle())
                                                                }
                                                                .padding(10) // Adjust padding as needed
                                                            }
                                HStack{
                                    VStack(alignment: .leading){
                                        
                                        Text("\(Stylist.distance, specifier: "%.1f") miles away")
                                            .font(.custom("Poppins-Italic", size: 15))
                                            .lineLimit(1)
                                        Text("Rating: \(Stylist.rating, specifier: "%.1f")")
                                            .font(.custom("Poppins-SemiBold", size: 15))
                                            .lineLimit(1)
                                    }
                                    
                                    Spacer()
                                    CircularProgressView(progress: CGFloat(Stylist.matchingPercentage) / 100.0)
                                        .frame(width: 80, height: 90)
                                }
                            }
                        }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
            }
        
        }

struct CustomNavigationBar: View {
    var body: some View {
        ZStack {
            HStack {
                Text("UMI") // Use your logo asset name
                    .font(.custom("Sarina-Regular", size: 15))
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: 80, alignment: .leading)
                
                Spacer() // This will push the name towards center
            
                Text("Stylists For You")
                    .font(.custom("Sansita-BoldItalic", size: 25))
                    .foregroundColor(Color("TitleTextColor"))
                    .frame(maxWidth: .infinity, alignment: .center) // Center the name text
                
                Spacer()
                
                Button(action: {
                    // Action for search button
                }) {
                    Image(systemName: "person")
                        .imageScale(.large)
                        .accentColor(.black)
                }
                .frame(width: 80, alignment: .trailing) // Right-aligned button
            }
            .padding(.horizontal)
        }
        .frame(height: 60) // Adjust the height as necessary
    }
}


struct CircularProgressView: View {
    var progress: CGFloat // Expect a value between 0.0 and 1.0
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("PrimaryColor"))
                .rotationEffect(Angle(degrees: -90)) // Start the progress from the top
                .animation(.linear, value: progress)
            
            Text("\(Int(progress * 100))%")
                .font(.system(size:15))
                .bold()
        }
    }
}

struct StylistForYouScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StylistForYouScreenView()
    }
}

// TODO: Link to StylistViewProfile()
