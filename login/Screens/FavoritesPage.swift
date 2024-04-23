////
////  FavoritesPage.swift
////  UMI
////
////  Created by Cyril John on 4/4/24.
//
//
import Foundation
import SwiftUI

// Assuming the Stylist struct remains unchanged

struct FavoritesPageView: View {
    @StateObject var viewModel = ClientViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                FavoritesNavigationBar()
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                } else if viewModel.favoriteStylists.isEmpty {
                    // Displaying a message when the list is empty
                    Text("You have no favorites yet.")
                        .font(.custom("Sansita-BoldItalic", size: 25))
                        .foregroundColor(Color("PrimaryColor"))
                        .padding()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(viewModel.favoriteStylists, id: \.id) { stylist in
                                NavigationLink(destination: StylistViewProfile(stylistId: stylist.id, viewModel: viewModel)) {
                                    FavoriteStylistSummaryView(stylist: stylist, viewModel: viewModel)
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
            viewModel.getFavoriteStylists { success in
                if success {
                    print("Favorite stylists fetched successfully")
                    // Debugging statement to check the count of favorites
                    print("Number of favorite stylists: \(viewModel.favoriteStylists.count)")
                } else {
                    print("Failed to fetch favorite stylists")
                }
                
                // Additional debug to check if the list is empty
                if viewModel.favoriteStylists.isEmpty {
                    print("The list of favorite stylists is currently empty.")
                }
            }
        }
    }
}





// StylistSummaryView and other supporting views (CustomNavigationBar, CircularProgressView) remain unchanged

// You might add a PreviewProvider for FavoritesPageView if needed for SwiftUI Previews
//struct FavoriteStylistSummaryView: View {
//    @State private var isFavorite = true  // Since this view displays favorites, start with `true`
//    
//    let stylist: FavoriteStylist
//    let viewModel: ClientViewModel
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text("\(stylist.fname) \(stylist.lname)")
//                .font(.custom("Poppins-SemiBold", size: 25))
//                .foregroundColor(Color("PrimaryColor"))
//
//            ZStack(alignment: .bottomTrailing) {
//                // Using a temporary image placeholder as in your example
//                ZStack {
//                    Rectangle().fill(Color.gray.opacity(0.3)) // Placeholder
//                    Image("BarberProfile") // Your image
//                        .resizable() // Make sure to add resizable() to scale the image correctly
//                        .scaledToFit() // Or .scaledToFill() depending on your needs
//                }
//
//                Button(action: {
//                    viewModel.removeFromFavorites(stylistId: stylist.id) { success in
//                        DispatchQueue.main.async {
//                            if success {
//                                viewModel.getFavoriteStylists { _ in
//                                    isFavorite = false  // This line ensures the view updates based on the new state
//                                }
//                            } else {
//                                print("Failed to remove stylist from favorites")
//                            }
//                        }
//                    }
//                }) {
//                    Image(systemName: isFavorite ? "heart.fill" : "heart")
//                        .font(.system(size: 30))
//                        .foregroundColor(Color("PrimaryColor"))
//                        .padding(10)
//                        .background(Color.white.opacity(0.5))
//                        .clipShape(Circle())
//                }
//                .padding(10)
//
//            }
//
//            HStack {
//                VStack(alignment: .leading) {
//                    Text("Average Price: $\(stylist.avgPrice, specifier: "%.2f")")
//                        .font(.custom("Poppins-SemiBold", size: 20))
//                        .foregroundColor(.black)
//                    Text("Rating: \(stylist.rating ?? 0.0, specifier: "%.1f")")
//                        .font(.custom("Poppins-Regular", size: 15))
//                        .foregroundColor(.black)
//                }
//                
//                Spacer()
//                // Since we don't have a match percentage, consider replacing or removing this element
//                // CircularProgressView(progress: CGFloat(stylist.matchPercentage) / 100.0)
//                //    .frame(width: 80, height: 90)
//                //    .foregroundColor(.black)
//            }
//        }
//    }
//}

struct FavoriteStylistSummaryView: View {
    let stylist: FavoriteStylist
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
                Image("BarberProfile")
                    .resizable()
                    .scaledToFit()

                Button(action: {
                    viewModel.removeFromFavorites(stylistId: stylist.id) { success in
                        DispatchQueue.main.async {
                            if success {
                                viewModel.getFavoriteStylists { _ in }
                                // isFavorite is now bound directly to the model, no need to set it here
                            } else {
                                print("Failed to remove stylist from favorites")
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
                    Text("Average Price: $\(stylist.avgPrice, specifier: "%.2f")")
                        .font(.custom("Poppins-SemiBold", size: 20))
                        .foregroundColor(.black)
                    Text("Rating: \(stylist.rating ?? 0.0, specifier: "%.1f")")
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(.black)
                }
                
                Spacer()
            }
        }
    }
}



struct FavoritesNavigationBar: View {
    var body: some View {
        ZStack {
            HStack {
                Text("UMI") // Use your logo asset name
                    .font(.custom("Sarina-Regular", size: 15))
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: 80, alignment: .leading)
                
                Spacer() // This will push the name towards center
            
                Text("My Favorites")
                    .font(.custom("Sansita-BoldItalic", size: 25))
                    .foregroundColor(Color("TitleTextColor"))
                    .frame(maxWidth: .infinity, alignment: .center) // Center the name text
                
                Spacer()
                
                Button(action: {
                    // Action for search button
                }) {
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

struct FavoritesPageView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesPageView()
    }
}
