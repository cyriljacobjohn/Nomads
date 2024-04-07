//
//  HairGenderSelectionScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 3/19/24.
//

import SwiftUI

struct ClientHairGenderSelectionScreenView: View {
    @EnvironmentObject var viewModel: UserRegistrationViewModel
    @State private var selectedHairGender: Int? = nil
    @State private var shouldNavigateToNextScreen = false
    @State private var showingAlert = false

    let hairGenderOptions = [
        ("Feminine", 7),
        ("Masculine", 8),
        ("Androgynous", 9)
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
                        Text("My Hair Is...")
                            .font(.custom("Sansita-BoldItalic", size: 50))
                            .foregroundColor(Color("TitleTextColor"))
                        
                        ForEach(hairGenderOptions, id: \.1) { option in
                            Button(action: { selectHairGender(option.1) }) {
                                buttonText(option.0, isSelected: self.selectedHairGender == option.1)
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
                            .foregroundColor(selectedHairGender == nil ? Color("PrimaryColor") : Color.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedHairGender == nil ? Color.white : Color("PrimaryColor"))
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    }
                    .padding(.vertical)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text("Please make a selection."), dismissButton: .default(Text("OK")))
                    }

                    NavigationLink("", destination: ClientHairIDScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                }
                .padding()
            }
        }
    }

    private func selectHairGender(_ gender: Int) {
        withAnimation(.easeInOut(duration: 0.2)) {
            self.selectedHairGender = gender
            viewModel.hairProfile.hairGender = gender
        }
    }

    private func continueAction() {
        if selectedHairGender == nil {
            showingAlert = true
        } else {
            shouldNavigateToNextScreen = true
        }
    }
}

struct ClientHairGenderSelectionScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ClientHairGenderSelectionScreenView().environmentObject(UserRegistrationViewModel())
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
