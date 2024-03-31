//
//  NameEntryScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 3/18/24.
//

import SwiftUI

struct NameEntryScreenView: View {
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var distance: Double = 1
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
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Let's Get")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                            
                            Text("Started")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                                .padding(.bottom, 20)

                            Text("Name")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                            
                            TextField("Ayomide Fatoye", text: $name)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                                .padding(.top, -8)
                                .padding(.bottom, 20)
                            
                            Text("Address")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                            
                            TextField("123 Main Street", text: $address)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                                .padding(.top, -8)
                                .padding(.bottom, 20)
                            
                            Text("Distance Preferences")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.top)
                                .padding(.bottom, 10)
                            
                            Slider(value: $distance, in: 1...100, step: 1)

                            HStack {
                                Spacer()
                                Text("\(Int(distance)) mile(s) from my address")
                                    .font(.custom("Poppins-Italic", size: 18))
                                    .padding(.bottom, 20)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    Button(action: continueAction) {
                        Text("Continue")
                            .font(.title3)
                            .foregroundColor(name.isEmpty || address.isEmpty ? Color("PrimaryColor") : Color.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(name.isEmpty || address.isEmpty ? Color.white : Color("PrimaryColor"))
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                    }
                    .padding(.vertical)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text("Please fill in all fields."), dismissButton: .default(Text("OK")))
                    }

                    NavigationLink("", destination: HairGenderSelectionScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                }
                .padding()
            }
        }
    }

    private func continueAction() {
        if name.isEmpty || address.isEmpty {
            showingAlert = true
        } else {
            sendDataToBackend()
            shouldNavigateToNextScreen = true
        }
    }

    private func sendDataToBackend() {
        // TODO: Implement logic to send data to backend
        print("Sending data to backend: Name: \(name), Address: \(address), Distance: \(distance)")
    }
}

struct NameEntryScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NameEntryScreenView()
    }
}
