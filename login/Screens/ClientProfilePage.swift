//
//  ClientProfilePage.swift
//  UMI
//
//  Created by Cyril John on 4/4/24.
//

import SwiftUI

struct ClientProfile: Identifiable {
    let id: UUID
    let name: String
    let description :String
    let hairGender: String
    let hairThickness: String
    let hairType: String
    let colorHistory: String
    let interests: [String]
    let currentHair: [String] // URLs of portfolio images
    let inspoHair: [String] // URLs of portfolio images
   
}
struct ClientProfileView: View {
    var clientId: UUID
        @State private var client: ClientProfile?
        
        @State private var selectedSegment: Int = 0
        
        var body: some View {
            VStack(spacing: 0) {
                if let client = client {
                    ProfileNavigationBar(name: client.name)
                    CustomSegmentedControl(selectedSegment: $selectedSegment, segments: ["View ", "Edit "])
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            if selectedSegment == 0 {
                                // Profile Section
                                
                                if let firstCurrentHairUrl = client.currentHair.first {
                                    ImageSectionView(title: nil, imageUrls: [firstCurrentHairUrl])
                                        .padding(.bottom)
                                }
                                
                                
                                ClientDescriptionView(title:"What I'm looking for", description: client.description)
                                    
                    
                                ClientProfileCardView(client: client)
                                    .padding(.bottom)
                                
                                ClientInterestsView(interests: client.interests)
                                
                                // Replace the second instance of ClientDescriptionView with ClientColorHistoryView
                                ClientColorHistoryView(title:"Color History", colorHistory: client.colorHistory)
                                    
                                   
                                // "Current Hair" section
                                if client.currentHair.count > 1 {
                                    ImageSectionView(title: "Current Hair", imageUrls: Array(client.currentHair.dropFirst()))
                                }
                                
                                // "Hair Inspiration" section
                                if !client.inspoHair.isEmpty {
                                    ImageSectionView(title: "Hair Inspiration", imageUrls: client.inspoHair)
                                }
    
                            } else {
                                // Edit Section
                                // ... Add your existing code for edit section
                            }
                        }
                        .padding()
                    }
                } else {
                    Text("Loading...")
                }
            }
            .onAppear {
                fetchClientProfile()
            }
        }
        
        private func fetchClientProfile() {
            // Fetch client profile based on clientId
            // This is dummy data, replace with actual data fetching logic
            client = ClientProfile(
                id: clientId,
                name: "Jamie Doe",
                description: "Looking to try something new with my hair.",
                hairGender: "Female",
                hairThickness: "Medium",
                hairType: "Wavy",
                colorHistory: "Occasionally dyed",
                interests: ["Curly Hair", "Coloring", "Highlights"],
                currentHair: [
                    "https://example.com/current1.jpg",
                    "https://example.com/current2.jpg"
                ],
                inspoHair: [
                    "https://example.com/inspo1.jpg",
                    "https://example.com/inspo2.jpg"
                ]
            )
        }
    }


struct ClientDescriptionView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("Poppins-Regular", size: 15))
                .foregroundColor(Color("PrimaryColor"))

            Text(description)
                .font(.custom("Poppins-SemiBold", size: 25))
        }
        
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1)
        .frame(maxWidth: .infinity)
        
    }
}

struct ClientProfileCardView: View {
    let client: ClientProfile
  
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
                ProfileSectionView(iconName: "person", text: client.hairGender) // Use proper SF Symbols
                Divider()
                ProfileSectionView(iconName: "star.fill", text: client.hairThickness)
                Divider()
                ProfileSectionView(iconName: "dollarsign.circle", text: client.hairType)
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

struct ClientInterestsView: View {
    let interests: [String]

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            Text("Interests")
                .font(.custom("Poppins-Regular", size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.top)
            Divider()
                .padding(.horizontal)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                ForEach(interests, id: \.self) { specialty in
                    Text(specialty)
                        .font(.custom("Poppins-Regular", size: 15))
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

struct ClientColorHistoryView: View {
    let title: String
    let colorHistory: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("Poppins-Regular", size: 15))
                .foregroundColor(Color("PrimaryColor"))

            Text(colorHistory)
                .font(.custom("Poppins-SemiBold", size: 25))
        }
        .padding() // Apply top and bottom padding here
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1)
        .frame(maxWidth: .infinity)
    }
}

struct ClientProfileSectionView: View {
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


// images
struct ImageSectionView: View {
    let title: String?
    let imageUrls: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let title = title, !title.isEmpty {
                Text(title)
                    .font(.custom("Poppins-SemiBold", size: 20))
                    .padding()
            }
            
            ForEach(imageUrls, id: \.self) { imageUrl in
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    Rectangle().fill(Color.gray.opacity(0.3))
                }
                .aspectRatio(contentMode: .fill)
                .cornerRadius(10)
                // Apply padding only if there is a title
                .padding(title != nil ? .vertical : [])
            }
        }
    }
}

struct ClientProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ClientProfileView(clientId: UUID())
    }
}
