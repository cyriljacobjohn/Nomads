//
//  StylistAddressScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 4/4/24.
//

import SwiftUI
import CoreLocation

struct StylistAddressScreenView: View {
    @EnvironmentObject var viewModel: UserRegistrationViewModel
    @State private var shouldNavigateToNextScreen = false
    @State private var showingAlert = false
    @State private var alertMessage = "Please fill in all fields."

    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack {
                        Text("UMI")
                            .font(.custom("Sarina-Regular", size: 35))
                            .foregroundColor(Color("PrimaryColor"))
                        
                        Spacer().frame(height: 20)
                        
                        VStack(alignment: .leading) {
                            Text("What's your address?")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                                .padding(.bottom, 20)

                            addressField(label: "Street", placeholder: "123 Main Street", text: $viewModel.address.street)
                            addressField(label: "City", placeholder: "New York", text: $viewModel.address.city)
                            addressField(label: "State", placeholder: "NY", text: $viewModel.address.state)
                            addressField(label: "Zip Code", placeholder: "10001", text: $viewModel.address.zipCode)
                            addressField(label: "Country", placeholder: "USA", text: $viewModel.address.country)
                        }
                        .padding(.horizontal)

                        Button(action: continueAction) {
                            Text("Continue")
                                .font(.title3)
                                .foregroundColor(viewModel.address.isEmpty() ? Color("PrimaryColor") : Color.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(viewModel.address.isEmpty() ? Color.white : Color("PrimaryColor"))
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                        }
                        .padding(.vertical)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }

                        NavigationLink("", destination: StylistPriceScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                    }
                    .padding()
                }
            }
        }
    }

    private func continueAction() {
        if viewModel.address.isEmpty() {
            alertMessage = "Please fill in all fields."
            showingAlert = true
        } else {
            geocodeAddress()
        }
    }

    private func geocodeAddress() {
        let address = "\(viewModel.address.street), \(viewModel.address.city), \(viewModel.address.state), \(viewModel.address.zipCode), \(viewModel.address.country)"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if error != nil {
                alertMessage = "Please enter a valid address."
                showingAlert = true
            } else if let location = placemarks?.first?.location {
                shouldNavigateToNextScreen = true
            } else {
                alertMessage = "No valid location found for the address provided."
                showingAlert = true
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
                .padding(.top, -8)
                .padding(.bottom, 20)
        }
    }
}

struct StylistAddressScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StylistAddressScreenView().environmentObject(UserRegistrationViewModel())
    }
}
