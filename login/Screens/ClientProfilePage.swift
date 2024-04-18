//
//  ClientProfilePage.swift
//  UMI
//
//  Created by Cyril John on 4/4/24.
//


//struct ClientProfileView: View {
//
//    var clientId: Int
//    @StateObject private var viewModel = ClientViewModel()
//    @State private var selectedSegment: Int = 0
//
//    //________________EDIT_________________________________
//
//    @State private var editableAddress: ClientProfile.Address
//    @State private var editableStylistsShouldKnow: String
//    @State private var editableInterests: [String]
//
//    var body: some View {
//        VStack(spacing: 0) {
//            if viewModel.isLoading {
//                ProgressView("Loading...")
//            } else if let client = viewModel.client {
//                ProfileNavigationBar(name: "\(client.fname) \(client.lname)")
//                CustomSegmentedControl(selectedSegment: $selectedSegment, segments: ["View", "Edit"])
//                    .padding()
//
//                ScrollView {
//                    VStack(alignment: .leading) {
//                        if selectedSegment == 0 {
//                            ClientDescriptionView(title: "What I'm looking for", description: client.stylistsShouldKnow)
//                                .padding(.bottom)
//
//                            ClientProfileCardView(client: client)
//                                .padding(.bottom)
//
//                            ClientInterestsView(interests: client.interests)
//                                .padding(.bottom)
//
//                            ClientDescriptionView(title: "Color History", description: client.hairProfile.colorHist)
//                        } else {
//                            Text("Edit Section Not Implemented")
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//            } else if let errorMessage = viewModel.errorMessage {
//                Text("Error: \(errorMessage)")
//            } else {
//                Text("Client profile not available.")
//            }
//        }
//        .onAppear {
//            viewModel.fetchClientProfile(clientId: clientId)
//        }
//    }
//}

import SwiftUI

struct ClientProfileView: View {
    
    var clientId: Int
    @StateObject private var viewModel = ClientViewModel()
    @State private var selectedSegment: Int = 0
    
    @State private var editableAddress: ClientProfile.Address = ClientProfile.Address(
        street: "",
        city: "",
        state: "",
        zipCode: 0,
        country: "",
        comfortRadius: 0.0,
        longitude: 0.0,
        latitude: 0.0
    ) // Default values must be predefined
    @State private var editableStylistsShouldKnow: String = ""
    @State private var editableInterests: [String] = []


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
                            displayClientInformation(client)
                        } else {
                            editClientInformation()
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
        .onChange(of: viewModel.client) { newValue in
            if let newClient = newValue {
                self.editableAddress = newClient.address
                self.editableStylistsShouldKnow = newClient.stylistsShouldKnow
                self.editableInterests = newClient.interests
            }
        }
    }
    
    @ViewBuilder
    private func displayClientInformation(_ client: ClientProfile) -> some View {
        ClientDescriptionView(title: "What I'm looking for", description: client.stylistsShouldKnow)
            .padding(.bottom)

        ClientProfileCardView(client: client)
            .padding(.bottom)

        ClientInterestsView(interests: client.interests)
            .padding(.bottom)

        ClientDescriptionView(title: "Color History", description: client.hairProfile.colorHist)
    }

    @ViewBuilder
    private func editClientInformation() -> some View {
        EditableAddressView(address: $editableAddress)
        EditableTextView(title: "Stylists Should Know", text: $editableStylistsShouldKnow)
        
        // Make sure this view is always included, even if editableInterests is empty
        if let client = viewModel.client {
               InterestsSelectionView(
                   viewModel: viewModel,
                   clientId: clientId,
                   selectedInterests: $viewModel.editableInterests,
                   clientInterests: client.interests // Add this line
               )
           }
  
        
        HStack {
            Text("Comfort Radius: \(editableAddress.comfortRadius, specifier: "%.1f") miles")
                .font(.custom("Poppins-Regular", size: 20))
            Slider(value: $editableAddress.comfortRadius, in: 0...100, step: 0.5)
                .accentColor(editableAddress.comfortRadius > 0 ? Color("PrimaryColor") : Color.gray)
        }
        .padding()

        Button(action: {
            saveChanges()
        }, label: {
            Text("Save Changes")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color("PrimaryColor")) // Text color inside the button
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white) // Background color of the button
                .cornerRadius(50.0) // Rounded corners
                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16) // Shadow
                .padding(.vertical)
        })
        .padding() // Padding around the button
    }


    private func saveChanges() {
        viewModel.updateClientAddress(clientId: clientId, address: editableAddress) { success, message in
            print("Address Update: \(message)")
        }
        viewModel.updateStylistsShouldKnow(clientId: clientId, text: editableStylistsShouldKnow) { success, message in
            print("Stylists Should Know Update: \(message)")
        }
        viewModel.updateComfortRadius(clientId: clientId, comfortRadius: editableAddress.comfortRadius) { success, message in
               // Handle the response
               print(message)
           }
        viewModel.updateClientInterests(clientId: clientId, interests: viewModel.editableInterests) { success, message in
                print("Interests Update: \(message)")
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


//struct EditableAddressView: View {
//    @Binding var address: ClientProfile.Address
//
//    var body: some View {
//        VStack(spacing: 16) {
//            TextField("Street", text: $address.street)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            TextField("City", text: $address.city)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            TextField("State", text: $address.state)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            TextField("Zip Code", value: $address.zipCode, formatter: NumberFormatter())
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            TextField("Country", text: $address.country)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//        }
//        .padding()
//    }
//}



struct EditableAddressView: View {
    @Binding var address: ClientProfile.Address
    
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all) // Background color
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("Your Address")
                        .font(.custom("Sarina-Regular", size: 35))
                        .foregroundColor(Color("PrimaryColor"))

                    VStack(alignment: .leading, spacing: 20) {
                        addressField(label: "Street", placeholder: "123 Main Street", text: $address.street)
                        addressField(label: "City", placeholder: "New York", text: $address.city)
                        addressField(label: "State", placeholder: "NY", text: $address.state)
                        // For Zip Code, since it's a numeric field, we retain the original formatting
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
    
    // This field function handles the zip code field which uses a value formatter
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


struct EditableTextView: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("Poppins-Regular", size: 15))
                .foregroundColor(Color("PrimaryColor"))
                .bold()

            TextEditor(text: $text)
                .font(.custom("Poppins-SemiBold", size: 18)) // Matching the description text font size for better UI consistency
                .frame(height: 200)
                .padding(4) // Adding padding inside the TextEditor for better text visibility
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1)) // Border styling
                .background(Color.white) // Background color for the text editor
                .cornerRadius(10) // Rounded corners to match ClientDescriptionView

            // Ensuring the text editor stretches to the full width available
            .frame(maxWidth: .infinity)
        }
        .padding() // Padding around the entire VStack
        .background(Color.white) // Background color of the entire view
        .cornerRadius(10) // Rounded corners of the outer VStack
        .shadow(radius: 1) // Subtle shadow for a lifted look
        .frame(maxWidth: .infinity) // Ensuring the VStack takes full width
    }
}


struct InterestsSelectionView: View {
    @ObservedObject var viewModel: ClientViewModel
    let clientId: Int

    @Binding var selectedInterests: [String]
    let clientInterests: [String]


    let allInterests = [
        "fine hair", "medium hair", "coarse hair",
        "straight hair", "wavy hair", "curly hair",
        "feminine", "masculine", "androgynous",
        "2A", "2B", "2C", "3A", "3B", "3C",
        "4A", "4B", "4C",
        "fades", "long haircuts", "color services",
        "braids", "alt cuts"
    ]
    
    let columns: [GridItem] = [
          GridItem(.flexible()),
          GridItem(.flexible())
      ]

    var body: some View {
        VStack {
            Text("Select Interests")
                .font(.custom("Poppins-Regular", size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.top)
            Divider()
                .padding(.horizontal)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                ForEach(allInterests, id: \.self) { interest in
                    Text(interest)
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(selectedInterests.contains(interest) ? .white : .black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedInterests.contains(interest) ? Color("PrimaryColor") : Color.gray)
                        .cornerRadius(10)
                        .onTapGesture {
                            toggleInterest(interest)
                        }
                }
            }
            .padding()
        }
        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, lineWidth: 0.5))
        .frame(maxWidth: .infinity)
        .onAppear {
                    // Initialize selectedInterests with the current interests of the client
                    self.selectedInterests = clientInterests
                }
    }

    private func toggleInterest(_ interest: String) {
        if let index = selectedInterests.firstIndex(of: interest) {
            selectedInterests.remove(at: index)
        } else {
            selectedInterests.append(interest)
        }
    }
}


// _______________________IMAGES________________________________
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
        ClientProfileView(clientId: 24)
    }
}
