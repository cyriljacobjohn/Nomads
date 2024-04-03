//
//  ClientAdditionalInformation.swift
//  UMI
//
//  Created by Sebastian Oberg on 4/3/24.
//


import SwiftUI

struct ClientAdditionalInformation: View {
    @State private var additionalInfo: String = ""
    @State private var navigateToCurlPatternScreen = false
    @State private var shouldNavigateToNextScreen = false
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        Text("UMI")
                            .font(.custom("Sarina-Regular", size: 35))
                            .foregroundColor(Color("PrimaryColor"))

                        Spacer().frame(height: 40)
                        
                        VStack(alignment: .leading) {
                            Text("Anything Else We Should Know?")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                                .padding(.bottom, 20)
                            
                            Text("Is there anything you would like your stylist to know?")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)

                            TextEditor(text: $additionalInfo)
                                .frame(height: 200)
                                .padding(4)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(10.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    Button(action: continueAction) {
                        Text("Continue")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(!additionalInfo.isEmpty ? Color.white : Color("PrimaryColor"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(!additionalInfo.isEmpty ? Color("PrimaryColor") : Color.white.opacity(0.7))
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    }
                    .padding(.vertical)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text("Please provide the requested information."), dismissButton: .default(Text("OK")))
                    }

                    // Add your conditional NavigationLink here if needed
                }
                .padding()
            }
        }
    }

    private func continueAction() {
        if additionalInfo.isEmpty {
            showingAlert = true
        } else {
            sendDataToBackend()
            shouldNavigateToNextScreen = true
        }
    }

    private func sendDataToBackend() {
        // Implement the actual backend call here
        print("Sending additional information to backend: \(additionalInfo)")
    }
}

struct ClientAdditionalInformation_Previews: PreviewProvider {
    static var previews: some View {
        ClientAdditionalInformation()
    }
}
