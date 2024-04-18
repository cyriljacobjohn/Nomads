//
//  StylistProfilePage.swift
//  UMI
//
//  Created by Cyril John on 4/14/24.
//
import Foundation
import SwiftUI

struct StylistProfileView: View {
    
    var stylistId: Int
    @StateObject private var viewModel = ClientViewModel()
    @State private var stylistProfile: StylistProfile?
    @State private var selectedSegment: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let stylist = stylistProfile {
                ProfileNavigationBar(name: "\(stylist.fname) \(stylist.lname)")
                CustomSegmentedControl(selectedSegment: $selectedSegment, segments: ["View", "Edit"])
                    .padding()

                ScrollView {
                    VStack(alignment: .leading) {
                        if selectedSegment == 0 {
                            StylistDescriptionView(title: "Clients Should Know", description: stylist.clientsShouldKnow)
                                .padding(.bottom)

                            StylistProfileCardView(stylist: stylist)
                                .padding(.bottom)

                            StylistSpecialitiesView(specialities: stylist.specialities)
                                .padding(.bottom)

                            StylistDescriptionView(title: "Address", description: stylist.address.formattedAddress)
                        } else {
                            Text("Edit Section Not Implemented")
                        }
                    }
                    .padding(.horizontal)
                }
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                Text("Stylist profile not available.")
            }
        }
        .onAppear {
            fetchStylistProfile()
        }
    }
    
    private func fetchStylistProfile() {
        viewModel.fetchStylistProfileById(stylistId: stylistId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self.stylistProfile = profile
                    // Create and assign a Stylist object based on the fetched profile
                case .failure(let error):
                    print("Failed to fetch stylist profile:", error.localizedDescription)
                    // Optionally update some UI component to reflect the error
                }
            }
        }
    }
}

struct StylistDescriptionView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("Poppins-Regular", size: 15))
                .foregroundColor(Color("PrimaryColor"))
            Text(description)
                .font(.custom("Poppins-SemiBold", size: 25))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1)
        .frame(maxWidth: .infinity)
    }
}

struct StylistProfileCardView: View {
    let stylist: StylistProfile
  
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            VStack(alignment: .leading, spacing: 16) {
                ProfileSectionView(iconName: "star", text: String(format: "%.1f", stylist.rating ?? 0.0))
                                Divider()
                                ProfileSectionView(iconName: "dollarsign.circle", text: String(format: "$%.2f", stylist.avgPrice))
                                Divider()
                                ProfileSectionView(iconName: "mappin.and.ellipse", text: "\(stylist.address.city), \(stylist.address.state)")
            }
            .padding(.horizontal)
            .padding(.bottom)
            
        }
        .padding(.top)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(radius: 1)
        .frame(maxWidth: .infinity)
    }
}

struct StylistSpecialitiesView: View {
    let specialities: [String]

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            Text("Specialities")
                .font(.custom("Poppins-Regular", size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.top)
            Divider()
                .padding(.horizontal)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                ForEach(specialities, id: \.self) { specialty in
                    Text(specialty)
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("PrimaryColor"))
                        .foregroundColor(Color.black)
                        .cornerRadius(10)
                }
            }
            .padding()
            
        }
        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, lineWidth: 0.5 ))
        .frame(maxWidth: .infinity)
        
    }
}

struct StylistProfileView_Previews: PreviewProvider {
    static var previews: some View {
        StylistProfileView(stylistId: 1)
    }
}
