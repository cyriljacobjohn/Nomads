//
//  StylistSpecialtyScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 4/4/24.
//

import SwiftUI

struct StylistSpecialtyScreenView: View {
    @EnvironmentObject var viewModel: UserRegistrationViewModel
    @State private var selectedSpecialties: [Bool] = Array(repeating: false, count: 5)
    @State private var shouldNavigateToNextScreen = false
    @State private var showingAlert = false

    let specialties = [
        "Fades",
        "Long Haircuts",
        "Color Services",
        "Braids",
        "Alt Cuts"
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
                        Text("Cuts I Can Perform")
                            .font(.custom("Sansita-BoldItalic", size: 50))
                            .foregroundColor(Color("TitleTextColor"))
                            .padding(.bottom, 20)

                        Text("Select all that apply:")
                            .font(.custom("Poppins-SemiBoldItalic", size: 20))
                        
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(specialties.indices, id: \.self) { index in
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        self.selectedSpecialties[index].toggle()
                                        updateSpecialties()
                                    }
                                }) {
                                    buttonText(specialties[index], isSelected: self.selectedSpecialties[index])
                                }
                                .padding(.bottom, 5)
                            }
                        }
                        .padding(.horizontal)
                        
                        Button(action: continueAction) {
                            Text("Continue")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(selectedSpecialties.contains(true) ? Color.white : Color("PrimaryColor"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(selectedSpecialties.contains(true) ? Color("PrimaryColor") : Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        }
                        .padding(.vertical)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text("Please make a selection."), dismissButton: .default(Text("OK")))
                        }
                        NavigationLink("", destination: StylistAdditionalInformationScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                    }
                    .padding()
                }
            }
        }
    }

    private func continueAction() {
        if !selectedSpecialties.contains(true) {
            showingAlert = true
        } else {
            shouldNavigateToNextScreen = true
        }
    }

    private func updateSpecialties() {
        let specialtyMapping = [19, 20, 21, 22, 23] // Mapping specialties to their integer values
        viewModel.specialties = selectedSpecialties.enumerated().compactMap { index, isSelected in
            isSelected ? specialtyMapping[index] : nil
        }
    }
}

struct StylistSpecialtyScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StylistSpecialtyScreenView().environmentObject(UserRegistrationViewModel())
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
