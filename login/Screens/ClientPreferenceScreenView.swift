//
//  PreferenceScreenView.swift
//  UMI
//
//  Created by Cyril John on 3/30/24.
//


import SwiftUI

struct ClientPreferenceScreenView: View {
    @State private var selectedRaces: [Bool] = Array(repeating: false, count: 6)
    @State private var shouldNavigateToNextScreen = false
    @State private var showingAlert = false

    let races = [
        "High Fades",
        "Low Fades",
        "Long Feminine Cuts",
        "Long Masculine Cuts",
        "Blonde Services",
        "Braids",
        // Add more if needed
    ]

    private var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 15), count: 2)
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)

                VStack {
                    Text("UMI")
                        .font(.custom("Sarina-Regular", size: 35))
                        .foregroundColor(Color("PrimaryColor"))
                        .padding(.top, 20)

                    Spacer()

                    VStack(alignment: .leading) {
                        Text("I'm Looking")
                            .font(.custom("Sansita-BoldItalic", size: 50))
                            .foregroundColor(Color("TitleTextColor"))
                        
                        Text("For")
                            .font(.custom("Sansita-BoldItalic", size: 50))
                            .foregroundColor(Color("TitleTextColor"))
                            .padding(.bottom, 20)
                        
                        Text("Select all that apply:")
                            .font(.custom("Poppins-SemiBoldItalic", size: 20))
                        
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(races.indices, id: \.self) { index in
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
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
                        NavigationLink("", destination: ClientCurrentHairScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                    }
                    .padding()
                }
            }
        }
    }

    private func continueAction() {
        if !selectedRaces.contains(true) {
            showingAlert = true
        } else {
            sendDataToBackend()
            shouldNavigateToNextScreen = true
        }
    }

    private func sendDataToBackend() {
        // Implement the actual backend call here
        print("Sending selected races to backend: \(selectedRaces)")
    }
}

struct ClientPreferenceScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ClientPreferenceScreenView()
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
