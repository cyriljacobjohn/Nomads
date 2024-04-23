//
//  ForYouScreenView.swift
//  UMI
//
//  Created by Cyril John on 3/30/24.
//

//
//  ForYouScreenView.swift
//  UMI
//
//  Created by Cyril John on 3/30/24.
//

import Foundation
import SwiftUI


enum SortOption {
    case matchPercentage
    case distance
    case rating
    case avgPrice
}

struct DiscoveryPageView: View {
    
    @StateObject var viewModel = ClientViewModel()
    @State private var progress: CGFloat = 0.0
    @State private var favoriteStylists: [Int] = []
    
    @State private var selectedSortOption: SortOption = .matchPercentage
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomNavigationBar(selectedSortOption: $selectedSortOption)

                            
                if viewModel.isLoading {
                    
                    ProgressView("Loading...")
                    
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                } else {
                
                    ScrollView {
                        
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(viewModel.sortedStylists) { stylist in
        
                                NavigationLink(destination: stylistCardTapped(stylistId: stylist.id)) {
                                    
                                    StylistSummaryView(stylist: stylist, viewModel: viewModel)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                    
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
            }
        }
        .onAppear {
            viewModel.fetchStylists { success in
                if success {
                    viewModel.getFavoriteStylists { _ in }
                    print("Stylists fetched successfully")
                } else {
                    print("Failed to fetch stylists")
                }
            }
        }
        .onChange(of: selectedSortOption) { newValue in
            viewModel.sortStylists(by: newValue)
        }
        
    }
    private func stylistCardTapped(stylistId: Int) -> some View {
           StylistViewProfile(stylistId: stylistId, viewModel: viewModel)
       }
    
}


struct StylistSummaryView: View {
    let stylist: Stylist
    @ObservedObject var viewModel: ClientViewModel
    
    var body: some View {
        let isFavorite = Binding<Bool>(
            get: { viewModel.isStylistFavorite(stylistId: stylist.id) },
            set: { _ in } // No operation needed on set; favorites are managed via actions
        )

        VStack(alignment: .leading, spacing: 8) {
            Text("\(stylist.fname) \(stylist.lname)")
                .font(.custom("Poppins-SemiBold", size: 25))
                .foregroundColor(Color("PrimaryColor"))
            
            ZStack(alignment: .bottomTrailing) {
                Rectangle().fill(Color.gray.opacity(0.3)) // Placeholder
                Image("BarberProfile") // Your image
                    .resizable()
                    .scaledToFit()
                
                Button(action: {
                    // Always add to favorites since this view should only add, not remove
                    viewModel.addToFavorites(stylistId: stylist.id) { success in
                        DispatchQueue.main.async {
                            if success {
                                viewModel.getFavoriteStylists { _ in
                                    // No need to manually update isFavorite here since the Binding takes care of it
                                }
                            } else {
                                print("Failed to add stylist to favorites")
                            }
                        }
                    }
                }) {
                    Image(systemName: isFavorite.wrappedValue ? "heart.fill" : "heart")
                        .font(.system(size: 30))
                        .foregroundColor(Color("PrimaryColor"))
                        .padding(10)
                        .background(Color.white.opacity(0.5))
                        .clipShape(Circle())
                }
                .padding(10)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("\(stylist.distance, specifier: "%.1f") miles away")
                        .font(.custom("Poppins-SemiBold", size: 20))
                        .foregroundColor(.black)
                    Text("Rating: \(stylist.rating ?? 0.0, specifier: "%.1f")")
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(.black)
                    Text("Avg Price: \(stylist.avgPrice, specifier: "%.1f")")
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(.black)
                }
                
                Spacer()
                CircularProgressView(progress: CGFloat(stylist.matchPercentage) / 100.0)
                    .frame(width: 80, height: 90)
                    .foregroundColor(.black)
            }
        }
    }
}


struct CustomNavigationBar: View {
    @Binding var selectedSortOption: SortOption
    @State private var showingSortOptions = false
    
    var body: some View {
        ZStack {
            HStack {
                Text("UMI") // Use your logo asset name
                    .font(.custom("Sarina-Regular", size: 15))
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: 80, alignment: .leading)
                
                Spacer() // This will push the name towards the center
                
                Text("Stylists For You")
                    .font(.custom("Sansita-BoldItalic", size: 25))
                    .foregroundColor(Color("TitleTextColor"))
                    .frame(maxWidth: .infinity, alignment: .center) // Center the name text
                
                Spacer()
                
                Menu {
                    Button("Match %", action: { selectedSortOption = .matchPercentage })
                    Button("Distance", action: { selectedSortOption = .distance })
                    Button("Rating", action: { selectedSortOption = .rating })
                    Button("Avg Price", action: { selectedSortOption = .avgPrice })
                    
                } label: {
                    Image(systemName: "line.horizontal.3.decrease.circle.fill")
                        .imageScale(.large)
                        .accentColor(Color("PrimaryColor"))
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
                .font(.custom("Poppins-Regular", size: 15))
                .bold()
        }
    }
}

struct DiscoveryPageView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryPageView()
    }
}
