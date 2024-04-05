//
//  StylistLandingPage.swift
//  UMI
//
//  Created by Cyril John on 4/1/24.
//

import SwiftUI

struct StylistProfileView: View {
    var stylistId: UUID
    @State private var stylist: StylistProfile?
    @State private var selectedSegment: Int = 0
    @State private var showingAddReview = false
    
    @State private var images: [String] = [] // Add this line
    @State private var texts: [EditableText] = [] // Add this line
    
    // Example tags - these might be fetched from a database or API in a real app
    let availableTags = ["fades", "blonde services", "long haircuts"]
    @State private var showingFilterView = false
    @State private var filterTags: [String] = []
    
    var body: some View {
        VStack(spacing: 0) {
            if let stylist = stylist {
                ProfileNavigationBar(name: stylist.name)
                CustomSegmentedControl(selectedSegment: $selectedSegment, segments: ["View ", "Edit "])
                
                ScrollView {
                    VStack(alignment: .leading) {
                        if selectedSegment == 0 {
                            // Profile Section
                            AsyncImage(url: URL(string: stylist.profileImageUrl)) { image in
                                image.resizable()
                            } placeholder: {
                                Rectangle().fill(Color.gray.opacity(0.3))
                            }
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(10)
                            .padding(.bottom)
                            
                            // Personal Description
                            ProfileDescriptionView(title: "Something about me",description: stylist.description)
                                .padding(.bottom)
                            
                            ProfileCardView(stylist: stylist)
                               
                            
                            if let firstImageUrl = stylist.portfolioImages.first {
                                                            AsyncImage(url: URL(string: firstImageUrl)) { image in
                                                                image.resizable()
                                                            } placeholder: {
                                                                Rectangle().fill(Color.gray.opacity(0.3))
                                                            }
                                                            .aspectRatio(contentMode: .fill)
                                                            .cornerRadius(10)
                                                            .padding(.vertical)
                                                        }
                            SpecialtiesView(specialties: stylist.specialties)
                            
                            ForEach(stylist.portfolioImages.dropFirst(), id: \.self) { imageUrl in
                                                            AsyncImage(url: URL(string: imageUrl)) { image in
                                                                image.resizable()
                                                            } placeholder: {
                                                                Rectangle().fill(Color.gray.opacity(0.3))
                                                            }
                                                            .aspectRatio(contentMode: .fill)
                                                            .cornerRadius(10)
                                                            .padding(.vertical)
                                                        }
                            
                            
                        } else {
                            // Reviews Section
                            EditProfileView(images: $images, texts: $texts)
                        }
                    }
                    .padding()
                }
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            // Load the stylist profile data
            fetchStylistProfile()
        }
    }
    
    private func fetchStylistProfile() {
        // Fetch stylist profile based on stylistId
        stylist = StylistProfile(
            id: stylistId,
            name: "Alex Smith",
            address: "1234 Road Dr",
            priceRange: "$60 - $100",
            specialties: ["Curly Hair", "Coloring", "Fades"],
            profileImageUrl: "https://example.com/image1.jpg",
            portfolioImages: [
                "https://example.com/work1.jpg",
                "https://example.com/work2.jpg",
                "https://example.com/work3.jpg",
                "https://example.com/work3.jpg"
            ],
            matchingPercentage: 90,
            rating: 4.5,
            reviews: exampleReviews,
            description: "Hey I'm Alex and I love to create beautiful hairstyles."
        )
    }
}

struct ProfileDescriptionView: View {
      let title: String
      let description: String
      
      var body: some View {
          VStack(alignment: .leading) {
              Text(title)
                  .font(.custom("Poppins-Regular", size: 15))
                  .foregroundColor(Color("PrimaryColor"))
                  .padding(.bottom, 1)
              Text(description)
                  .font(.custom("Poppins-SemiBold", size: 25))
                  
          }
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.white)
          .cornerRadius(10)
          .shadow(radius: 1)
      }
}

struct ProfileCardView: View {
    let stylist: StylistProfile
  
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
//            HStack {
//                ProfileSectionView(iconName: "cake", text: age)
//                VerticalDivider()
//                ProfileSectionView(iconName: "person", text: gender)
//                VerticalDivider()
//                ProfileSectionView(iconName: "heart", text: orientation)
//            }
            
            VStack(alignment: .leading, spacing: 16) {
                ProfileSectionView(iconName: "mappin.and.ellipse", text: stylist.address) // Use proper SF Symbols
                Divider()
                ProfileSectionView(iconName: "star.fill", text: "\(String(format: "%.1f", stylist.rating))")
                Divider()
                ProfileSectionView(iconName: "dollarsign.circle", text: stylist.priceRange)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
        }
        .padding(.top)
        
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(radius: 1)
        .frame(maxWidth: .infinity) // Stretch to the ends
    }
}

struct ProfileSectionView: View {
    let iconName: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName) // Use SF Symbols for simplicity
            Text(text)
                .font(.custom("Poppins-Regular", size: 20))
        }
    }
}

struct SpecialtiesView: View {
    let specialties: [String]

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            Text("Specialties")
                .font(.custom("Poppins-Regular", size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.top)
            Divider()
                .padding(.horizontal)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                ForEach(specialties, id: \.self) { specialty in
                    Text(specialty)
                        .font(.custom("Poppins-SemiBold", size: 15))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("PrimaryColor")) // Light gray background
                        .foregroundColor(Color.black)
                        .cornerRadius(10)
                }
            }
            .padding()
            
        }
        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, lineWidth: 0.5 )) // Outer border
        .frame(maxWidth: .infinity)
        
    }
}


struct EditProfileView: View {
    @Binding var images: [String]
    @Binding var texts: [EditableText]
    
    var body: some View {
        ScrollView {
            // Photos Section
            VStack(alignment: .leading) {
                Text("MY PHOTOS & VIDEOS")
                    .font(.headline)
                    .padding(.leading)
                
                PhotoGridView(images: $images)
            }
            
            // Texts Section
            VStack(alignment: .leading) {
                Text("MY ANSWERS")
                    .font(.headline)
                    .padding(.leading)
                
                ForEach($texts) { $editableText in
                    EditableTextView(editableText: $editableText)
                }
            }
        }
    }
}

// Assumes PhotoGridView is another custom view that handles the display and editing of images
struct PhotoGridView: View {
    @Binding var images: [String] // Binding to the images array

    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(images.indices, id: \.self) { index in
                ZStack(alignment: Alignment.topTrailing) {
                    // Replace "ImageName" with your image rendering method.
                    Image(images[index]) // Assuming these are image names
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .cornerRadius(10)

                    Button(action: {
                        // Explicitly referencing 'self.images' to avoid ambiguity
                        self.images.remove(at: index)
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                            .padding(2)
                    }
                }
            }
        }
        .padding([.horizontal, .top])
    }
}



struct EditableTextView: View {
    @Binding var editableText: EditableText
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(editableText.title)
                .font(.headline)
            TextField("Type something...", text: $editableText.text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            // Add a delete button if necessary
        }
        .padding()
    }
}

// Helper struct for editable texts
struct EditableText: Identifiable {
    let id: UUID
    var title: String
    var text: String
}

// Note: Actual implementation for PhotoGridView and other custom views will be needed.


struct StylistProfileView_Previews: PreviewProvider {
    static var previews: some View {
        StylistProfileView(stylistId: UUID())
    }
}
