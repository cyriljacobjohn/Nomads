//
//  StylistAddressScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 4/4/24.
//

import SwiftUI
import CoreLocation

struct StylistAddressScreenView: View {
    @State private var street: String = ""
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var zipCode: String = ""
    @State private var country: String = ""
    @State private var distance: Double = 1
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
                            
                            Text("Distance Preferences")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.top)
                                .padding(.bottom, 10)
                            
                            Slider(value: $distance, in: 1...100, step: 1)
                            Text("\(Int(distance)) mile(s) from my address")
                                .font(.custom("Poppins-Italic", size: 18))
                                .padding(.bottom, 20)
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

                        NavigationLink("", destination: StylistPriceScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
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
            if error != nil {
                alertMessage = "Please enter valid address."
                showingAlert = true
            } else if (placemarks?.first?.location) != nil {
                sendDataToBackend()
                shouldNavigateToNextScreen = true
            } else {
                alertMessage = "No valid location found for the address provided."
                showingAlert = true
            }
        }
    }

    private func sendDataToBackend() {
        let backendData = "Street: \(street), City: \(city), State: \(state), Zip Code: \(zipCode), Country: \(country), Distance: \(distance) miles"
        print("Sending data to backend: \(backendData)")
        // Implement your backend communication logic here, sending `backendData`
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
        StylistAddressScreenView()
    }
}

