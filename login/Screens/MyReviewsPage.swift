//
//  MyReviewsPage.swift
//  UMI
//
//  Created by Cyril John on 4/4/24.
//

import SwiftUI

struct ClientReviewsPage: View {
    var clientReviews: [Review] // Array of reviews for the client
    @State private var showingFilterView = false
    @State private var showingAddReview = false
    @State private var filterTags: [String] = []
    let availableTags: [String] = ["Cutting", "Styling", "Coloring"] // Example tags, adjust as needed

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ReviewsNavigationBar()
                // Filter button
                HStack {
                    Button("Filter") {
                        showingFilterView = true
                    }
                    .foregroundColor(Color("PrimaryColor")) // Adjust the color as needed
                    .font(.custom("Poppins-SemiBold", size: 15))
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .shadow(radius: 3)
                    .popover(isPresented: $showingFilterView) {
                        FilterView(selectedTags: $filterTags, availableTags: availableTags)
                    }

                    Spacer()
                }
                .padding([.leading, .top, .trailing])
                
                // Reviews list
                VStack(spacing: 30) {
                    ForEach(clientReviews) { review in
                        ReviewEntryView(review: review)
                    }
                }
                Spacer()
                Spacer()
                
                // Add Review button

            }
        }
        .sheet(isPresented: $showingAddReview) {
            // Assuming you have an AddReviewView similar to the stylist's page
            AddReviewView()
        }
    }
}

struct ReviewsNavigationBar: View {
    @State private var showingFilterView = false
    var body: some View {
        ZStack {
            HStack {
                Text("UMI") // Left-aligned content, taking up fixed space
                    .font(.custom("Sarina-Regular", size: 15))
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: 80, alignment: .leading)
                
                Spacer() // Ensures center alignment of "My Reviews" by pushing everything else to the edges
                
                Text("My Reviews") // Center-aligned text
                    .font(.custom("Sansita-BoldItalic", size: 25))
                    .foregroundColor(Color("TitleTextColor"))
                    .frame(alignment: .center)
                
                Spacer() // Ensures the text remains centered by filling space equally on both sides
                
                Button(action: {
                    showingFilterView = true
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(Color("PrimaryColor"))
                }
                .frame(width: 80, alignment: .trailing) // Ensures button takes up fixed space and aligns to the right
            }
            .padding(.horizontal)
        }
        .frame(height: 60) // Adjust the height as necessary
    }
}





// Example client reviews, you would replace this with actual data
struct ClientReviewsPage_Previews: PreviewProvider {
    static var previews: some View {
        ClientReviewsPage(clientReviews: [
            Review(id: UUID(), customerName: "Customer A", rating: 4.5, comment: "Very professional and friendly!", tags: ["Cutting"]),
            Review(id: UUID(), customerName: "Customer B", rating: 5.0, comment: "Loved the styling!", tags: ["Styling", "Coloring"])
        ])
    }
}

