//
//  MyReviewsPage.swift
//  UMI
//
//  Created by Cyril John on 4/4/24.
//

import SwiftUI

struct MyReviewsView: View {
    
    @EnvironmentObject private var session: UserSessionManager
    @StateObject private var viewModel = ClientViewModel()
    @State private var showingFilterView = false
    
    var body: some View {
        VStack(spacing: 0) { // removed the spacing to reduce the gap
            ReviewsNavigationBar(showingFilterView: $showingFilterView)
            
            // Removed the standalone filter button here
            
            // Average rating encapsulated within a styled rectangle
            Text("Average Rating: \(viewModel.averageRating, specifier: "%.1f")")
                .font(.custom("Poppins-SemiBold", size: 18))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("PrimaryColor"))
                .cornerRadius(10)
                .padding(.horizontal)

            // Reviews list
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(viewModel.ratings) { review in
                        ReviewEntryView(review: review)
                    }
                }
                .padding(.bottom)
            }
        }
        .onAppear {
            if let stylistId = session.userId, session.userType == "stylist" {
                viewModel.getStylistRatings(stylistId: stylistId) { success in
                    if !success {
                        print("Error loading reviews: \(viewModel.errorMessage ?? "Unknown error")")
                    }
                }
            } else {
                viewModel.errorMessage = "Invalid user type or missing stylist ID"
            }
        }
        .sheet(isPresented: $showingFilterView) {
            // Your Filter View goes here
        }
    }
}

struct ReviewsNavigationBar: View {
    @Binding var showingFilterView: Bool
    
    var body: some View {
        ZStack {
            HStack {
                Text("UMI")
                    .font(.custom("Sarina-Regular", size: 15))
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: 80, alignment: .leading)
                
                Spacer()
                
                Text("My Reviews")
                    .font(.custom("Sansita-BoldItalic", size: 25))
                    .foregroundColor(Color("TitleTextColor"))
                
                Spacer()
                
                Button(action: {
                    showingFilterView.toggle()
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(Color("PrimaryColor"))
                }
                .frame(width: 80, alignment: .trailing)
            }
            .padding(.horizontal)
        }
        .frame(height: 60)
        .background(Color.white)
    }
}


// Example client reviews preview provider
struct MyReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        MyReviewsView().environmentObject(UserSessionManager.shared)
    }
}

