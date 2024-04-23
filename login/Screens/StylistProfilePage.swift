//
//  StylistProfilePage.swift
//  UMI
//
//  Created by Cyril John on 4/14/24.
//
import Foundation
import SwiftUI

//struct StylistProfileView: View {
//    
//    var stylistId: Int
//    @StateObject private var viewModel = ClientViewModel()
//    @State private var stylistProfile: StylistProfile?
//    @State private var selectedSegment: Int = 0
//
//    var body: some View {
//        VStack(spacing: 0) {
//            if viewModel.isLoading {
//                ProgressView("Loading...")
//            } else if let stylist = stylistProfile {
//                ProfileNavigationBar(name: "\(stylist.fname) \(stylist.lname)")
//                CustomSegmentedControl(selectedSegment: $selectedSegment, segments: ["View", "Edit"])
//                    .padding()
//
//                ScrollView {
//                    VStack(alignment: .leading) {
//                        if selectedSegment == 0 {
//                            StylistDescriptionView(title: "Clients Should Know", description: stylist.clientsShouldKnow)
//                                .padding(.bottom)
//
//                            StylistProfileCardView(stylist: stylist)
//                                .padding(.bottom)
//
//                            StylistSpecialitiesView(specialities: stylist.specialities)
//                                .padding(.bottom)
//
//                            StylistDescriptionView(title: "Address", description: stylist.address.formattedAddress)
//                        } else {
//                            Text("Nothing to edit")
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//            } else if let errorMessage = viewModel.errorMessage {
//                Text("Error: \(errorMessage)")
//            } else {
//                Text("Stylist profile not available.")
//            }
//        }
//        .onAppear {
//            fetchStylistProfile()
//        }
//    }
//    
//    private func fetchStylistProfile() {
//        viewModel.fetchStylistProfileById(stylistId: stylistId) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let profile):
//                    self.stylistProfile = profile
//                    // Create and assign a Stylist object based on the fetched profile
//                case .failure(let error):
//                    print("Failed to fetch stylist profile:", error.localizedDescription)
//                    // Optionally update some UI component to reflect the error
//                }
//            }
//        }
//    }
//}

struct StylistProfileView: View {
    
    var stylistId: Int
    @StateObject private var viewModel = ClientViewModel()
    @State private var stylistProfile: StylistProfile?
    @State private var editableAddress: Address?
    @State private var selectedSegment: Int = 0
    
    struct PrimaryButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        }
    }

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
                            // Directly adding the view content for "View" mode
                            StylistDescriptionView(title: "Clients Should Know", description: stylist.clientsShouldKnow)
                                .padding(.bottom)

                            StylistProfileCardView(stylist: stylist)
                                .padding(.bottom)

                            StylistSpecialitiesView(specialities: stylist.specialities)
                                .padding(.bottom)

                            StylistDescriptionView(title: "Address", description: stylist.address.formattedAddress)
                        } else {
                            // Directly adding the view content for "Edit" mode
//                            if let addressBinding = $editableAddress {
//                                StylistEditableAddress(address: addressBinding)
//                                Button("Save Changes") {
//                                    if let updatedAddress = editableAddress {
//                                        viewModel.updateStylistAddress(stylistId: stylistId, address: updatedAddress) { success, message in
//                                            print("Address Update: \(message)")
//                                        }
//                                    }
//                                }
//                                .buttonStyle(PrimaryButtonStyle())
//                            } else {
//                                Text("No address to edit.")
//                            }
                            Text("Edit")
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
        .onChange(of: selectedSegment) { _ in
            // When switching to the edit segment, update the editableAddress
            editableAddress = stylistProfile?.address
        }
    }
    
    private func fetchStylistProfile() {
        viewModel.fetchStylistProfileById(stylistId: stylistId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self.stylistProfile = profile
                    // Optionally, initialize editableAddress here if it should only be editable when the user enters edit mode
                case .failure(let error):
                    print("Failed to fetch stylist profile:", error.localizedDescription)
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


struct StylistEditableAddress: View {
    @Binding var address: Address  // Use Address from StylistProfile
    
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 20) {
                    Text("Your Address")
                        .font(.custom("Sarina-Regular", size: 35))
                        .foregroundColor(Color("PrimaryColor"))

                    VStack(alignment: .leading, spacing: 20) {
                        addressField(label: "Street", placeholder: "123 Main Street", text: $address.street)
                        addressField(label: "City", placeholder: "New York", text: $address.city)
                        addressField(label: "State", placeholder: "NY", text: $address.state)
                        addressField(label: "Zip Code", placeholder: "10001", value: $address.zipCode, formatter: NumberFormatter())
                        addressField(label: "Country", placeholder: "USA", text: $address.country)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
        }
    }
    
    private func addressField(label: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                .padding(.bottom, 10)
                
            TextField(placeholder, text: text)
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(50.0)
                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                .padding(.bottom, 20)
        }
    }

    private func addressField(label: String, placeholder: String, value: Binding<Int>, formatter: NumberFormatter) -> some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                .padding(.bottom, 10)
                
            TextField(placeholder, value: value, formatter: formatter)
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(50.0)
                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                .padding(.bottom, 20)
        }
    }
}


struct StylistProfileView_Previews: PreviewProvider {
    static var previews: some View {
        StylistProfileView(stylistId: 1)
    }
}
