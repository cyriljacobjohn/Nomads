//
//  RaceEthnicityScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 3/30/24.
//


import SwiftUI

import SwiftUI

struct ClientRaceEthnicityScreenView: View {
    @EnvironmentObject var viewModel: UserRegistrationViewModel
    @State private var selectedRaces: [Bool] = Array(repeating: false, count: 14)
    @State private var shouldNavigateToNextScreen = false
    @State private var showingAlert = false

    let races = [
        "Asian",
        "Berber",
        "Black or African",
        "Caucasian (White)",
        "Celtic",
        "Hispanic or Latino",
        "Jewish",
        "Middle Eastern",
        "Native American or Alaska Native",
        "Native Hawaiian or Other Pacific Islander",
        "Romani",
        "Scandinavian",
        "Slavic",
        "Turkic"
    ]

    private var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 15), count: 2)
    }

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
                            Text("Race And Ethnicity")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                                .padding(.bottom, 20)
                            
                            Text("Select all that apply:")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                            
                            LazyVGrid(columns: columns, spacing: 15) {
                                ForEach(races.indices, id: \.self) { index in
                                    Button(action: {
                                        withAnimation {
                                            self.selectedRaces[index].toggle()
                                        }
                                    }) {
                                        buttonText(races[index], isSelected: self.selectedRaces[index])
                                    }
                                    .padding(.bottom, 5)
                                }
                            }
                            .padding(.horizontal)
                            
                            Button(action: continueAction) {
                                Text("Continue")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(selectedRaces.contains(true) ? Color.white : Color("PrimaryColor"))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedRaces.contains(true) ? Color("PrimaryColor") : Color.white)
                                    .cornerRadius(50.0)
                                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                            }
                            .padding(.vertical)
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Error"), message: Text("Please make a selection."), dismissButton: .default(Text("OK")))
                            }

                            NavigationLink("", destination: ClientHairGenderSelectionScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                        }
                        .padding()
                    }
                }
            }
        }
    }

    private func continueAction() {
        if !selectedRaces.contains(true) {
            showingAlert = true
        } else {
            updateEthnicitySelection()
            shouldNavigateToNextScreen = true
        }
    }

    private func updateEthnicitySelection() {
        // Map the selected booleans to their respective race strings
        let selectedEthnicities = races.enumerated().compactMap { index, race in
            selectedRaces[index] ? race : nil
        }
        
        viewModel.ethnicity = selectedEthnicities // Assuming there is a `ethnicity` property in your ViewModel to hold this data
        print("Selected Ethnicities: \(selectedEthnicities)")
    }
}

struct ClientRaceEthnicityScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ClientRaceEthnicityScreenView().environmentObject(UserRegistrationViewModel())
    }
}

private func buttonText(_ text: String, isSelected: Bool) -> some View {
    Text(text)
        .font(.title3)
        .fontWeight(.bold)
        .foregroundColor(isSelected ? Color.white : Color("PrimaryColor"))
        .padding()
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color("PrimaryColor") : Color.white.opacity(0.7))
        .cornerRadius(50.0)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
        .padding(.vertical, 5)
}
