//
//  ClientProfilePage.swift
//  UMI
//
//  Created by Cyril John on 4/4/24.
//

import SwiftUI

struct ClientProfileView: View {
    
    var clientId: Int
    @StateObject private var viewModel = ClientViewModel()
    @State private var selectedSegment: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let client = viewModel.client {
                ProfileNavigationBar(name: "\(client.fname) \(client.lname)")
                CustomSegmentedControl(selectedSegment: $selectedSegment, segments: ["View", "Edit"])
                    .padding()

                ScrollView {
                    VStack(alignment: .leading) {
                        if selectedSegment == 0 {
                            ClientDescriptionView(title: "What I'm looking for", description: client.stylistsShouldKnow)
                                .padding(.bottom)

                            ClientProfileCardView(client: client)
                                .padding(.bottom)

                            ClientInterestsView(interests: client.interests)
                                .padding(.bottom)

                            ClientDescriptionView(title: "Color History", description: client.hairProfile.colorHist)
                        } else {
                            Text("Edit Section Not Implemented")
                        }
                    }
                    .padding(.horizontal)
                }
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                Text("Client profile not available.")
            }
        }
        .onAppear {
            viewModel.fetchClientProfile(clientId: clientId)
        }
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
                .fixedSize(horizontal: false, vertical: true) // Ensure text wraps correctly
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)// Apply padding on all sides
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1)
        .frame(maxWidth: .infinity) // Stretch to the full width
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
                ProfileSectionView(iconName: "figure", text: client.hairProfile.hairGender) // Corrected access
                                Divider()
                                ProfileSectionView(iconName: "line.horizontal.3.decrease", text: client.hairProfile.thickness) // Corrected access
                                Divider()
                                ProfileSectionView(iconName: "waveform.path.ecg.rectangle", text: client.hairProfile.hairType) // Corrected access
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
        ClientProfileView(clientId: 1)
    }
}
