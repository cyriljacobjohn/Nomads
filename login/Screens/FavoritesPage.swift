//
//  FavoritesPage.swift
//  UMI
//
//  Created by Cyril John on 4/4/24.


//import Foundation
//import SwiftUI
//
//// Assuming the Stylist struct remains unchanged
//
//struct FavoritesPageView: View {
//    @State private var favoriteStylistUUIDs: [UUID] // Provided list of favorite stylist UUIDs
//    @State private var stylists: [Stylist] = [] // This will be populated based on the favoriteStylistUUIDs
//    
//    init(favoriteStylistUUIDs: [UUID]) {
//        self._favoriteStylistUUIDs = State(initialValue: favoriteStylistUUIDs)
//        // Initialize your stylists array based on favoriteStylistUUIDs here
//        // For demonstration, I'm hardcoding stylists; you might fetch these from a server or local storage based on the UUIDs
//        self._stylists = State(initialValue: [
//            // Assuming these are your favorite stylists
//            Stylist(name: "Alex Smith", distance: 1.2, profileImageUrl: "https://example.com/image1.jpg", matchingPercentage: 90, rating: 2.6),
//            Stylist(name: "Jordan Doe", distance: 3.4, profileImageUrl: "https://example.com/image2.jpg", matchingPercentage: 85, rating: 4.6),
//        ].filter { favoriteStylistUUIDs.contains($0.id) }) // This filters the stylists to only include those in the favoriteStylistUUIDs list
//    }
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 0) {
//                FavoritesNavigationBar()
//                ScrollView {
//                    VStack(alignment: .leading, spacing: 20) {
//                        ForEach(stylists) { stylist in
//                            NavigationLink(destination: StylistViewProfile(stylistId: stylist.id)) {
//                                StylistSummaryView(stylist: stylist, favoriteStylists: $favoriteStylistUUIDs)
//                                    .padding()
//                                    .background(Color.white)
//                                    .cornerRadius(10)
//                                    .shadow(radius: 5)
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
//                }
//                .padding(.top)
//            }
//        }
//    }
//}
//
//// StylistSummaryView and other supporting views (CustomNavigationBar, CircularProgressView) remain unchanged
//
//// You might add a PreviewProvider for FavoritesPageView if needed for SwiftUI Previews
//
//struct FavoritesNavigationBar: View {
//    var body: some View {
//        ZStack {
//            HStack {
//                Text("UMI") // Use your logo asset name
//                    .font(.custom("Sarina-Regular", size: 15))
//                    .foregroundColor(Color("PrimaryColor"))
//                    .frame(width: 80, alignment: .leading)
//                
//                Spacer() // This will push the name towards center
//            
//                Text("My Favorites")
//                    .font(.custom("Sansita-BoldItalic", size: 25))
//                    .foregroundColor(Color("TitleTextColor"))
//                    .frame(maxWidth: .infinity, alignment: .center) // Center the name text
//                
//                Spacer()
//                
//                Button(action: {
//                    // Action for search button
//                }) {
//                    Image(systemName: "line.horizontal.3.decrease.circle.fill")
//                        .imageScale(.large)
//                        .accentColor(Color("PrimaryColor"))
//                }
//                .frame(width: 80, alignment: .trailing) // Right-aligned button
//            }
//            .padding(.horizontal)
//        }
//        .frame(height: 60) // Adjust the height as necessary
//    }
//}
//
//struct FavoritesPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleUUIDs = [UUID(), UUID()]
//        FavoritesPageView(favoriteStylistUUIDs: sampleUUIDs)
//    }
//}
