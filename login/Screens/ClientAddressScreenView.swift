//
//  ClientAddressScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 4/1/24.
//


import SwiftUI
import CoreLocation

struct ClientAddressScreenView: View {
    @State private var street: String = ""
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var zipCode: String = ""
    @State private var country: String = ""
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

                            addressField(label: "Street", placeholder: "123 Main Street", text: $street)
                            addressField(label: "City", placeholder: "New York", text: $city)
                            addressField(label: "State", placeholder: "NY", text: $state)
                            addressField(label: "Zip Code", placeholder: "10001", text: $zipCode)
                            addressField(label: "Country", placeholder: "USA", text: $country)
                        }
                        .padding(.horizontal)

                        Button(action: continueAction) {
                            Text("Continue")
                                .font(.title3)
                                .foregroundColor(street.isEmpty || city.isEmpty || state.isEmpty || zipCode.isEmpty || country.isEmpty ? Color("PrimaryColor") : Color.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(street.isEmpty || city.isEmpty || state.isEmpty || zipCode.isEmpty || country.isEmpty ? Color.white : Color("PrimaryColor"))
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                        }
                        .padding(.vertical)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }

                        NavigationLink("", destination: RaceEthnicityScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                    }
                    .padding()
                }
            }
        }
    }

    private func continueAction() {
        if street.isEmpty || city.isEmpty || state.isEmpty || zipCode.isEmpty || country.isEmpty {
            alertMessage = "Please fill in all fields."
            showingAlert = true
        } else {
            geocodeAddress()
        }
    }

    private func geocodeAddress() {
        let address = "\(street), \(city), \(state), \(zipCode), \(country)"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                alertMessage = "Please enter a valid address."
                showingAlert = true
            } else if let location = placemarks?.first?.location {
                sendDataToBackend(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                shouldNavigateToNextScreen = true
            } else {
                alertMessage = "No valid location found for the address provided."
                showingAlert = true
            }
        }
    }

    private func sendDataToBackend(latitude: Double, longitude: Double) {
        print("Sending coordinates to backend: Latitude: \(latitude), Longitude: \(longitude)")
        // Implement your backend communication logic here
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

struct ClientAddressScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ClientAddressScreenView()
    }
}
