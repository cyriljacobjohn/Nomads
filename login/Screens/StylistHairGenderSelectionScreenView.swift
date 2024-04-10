//
//  StylistHairGenderSelectionScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 4/9/24.
//

// TODO: CHANGE PROMPT AND BE ABLE TO SELECT ALL

import SwiftUI

struct StylistHairGenderSelectionScreenView: View {
    @EnvironmentObject var viewModel: UserRegistrationViewModel
    @State private var selectedHairGenders: [Int] = []
    @State private var shouldNavigateToNextScreen = false
    @State private var showingAlert = false

    let hairGenderOptions = [
        ("Feminine Hair", 7),
        ("Masculine Hair", 8),
        ("Androgynous Hair", 9)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("UMI")
                        .font(.custom("Sarina-Regular", size: 35))
                        .foregroundColor(Color("PrimaryColor"))

                    Spacer().frame(height: 40)
                    
                    VStack(alignment: .leading) {
                        Text("I Can Cut...")
                            .font(.custom("Sansita-BoldItalic", size: 50))
                            .foregroundColor(Color("TitleTextColor"))
                        
                        ForEach(hairGenderOptions, id: \.1) { option in
                            Button(action: { selectHairGender(option.1) }) {
                                buttonText(option.0, isSelected: self.selectedHairGenders.contains(option.1))
                            }
                            .padding(.bottom, -15)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(action: continueAction) {
                        Text("Continue")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(selectedHairGenders.isEmpty ? Color("PrimaryColor") : Color.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedHairGenders.isEmpty ? Color.white : Color("PrimaryColor"))
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    }
                    .padding(.vertical)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text("Please make a selection."), dismissButton: .default(Text("OK")))
                    }

                    NavigationLink("", destination: StylistHairIDScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                }
                .padding()
            }
        }
    }

    private func selectHairGender(_ gender: Int) {
        withAnimation(.easeInOut(duration: 0.2)) {
            if selectedHairGenders.contains(gender) {
                selectedHairGenders.removeAll(where: { $0 == gender })
            } else {
                selectedHairGenders.append(gender)
            }
            viewModel.specialties = selectedHairGenders
            viewModel.hairProfile.hairGender = gender
        }
    }

    private func continueAction() {
        if selectedHairGenders.isEmpty {
            showingAlert = true
        } else {
            shouldNavigateToNextScreen = true
        }
    }
}

struct StylistHairGenderSelectionScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StylistHairGenderSelectionScreenView().environmentObject(UserRegistrationViewModel())
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
        .padding(.vertical)
}
