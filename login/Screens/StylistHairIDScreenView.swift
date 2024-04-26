//
//  StylistHairIDScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 4/9/24.
//

import SwiftUI

struct StylistHairIDScreenView: View {
    @EnvironmentObject var viewModel: UserRegistrationViewModel
    @State private var navigateToCurlPatternScreen = false
    @State private var navigateToPreferenceScreen = false
    @State private var showingAlert = false
    @State private var selectedHairThicknesses: [Int] = []
    @State private var selectedHairTypes: [Int] = []

    var body: some View {
        NavigationView {
            ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
                ScrollView {
                    
                    VStack {
                        Text("UMI")
                            .font(.custom("Sarina-Regular", size: 35))
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(.top)
                        
                        Spacer().frame(height: 40)
                        
                        VStack(alignment: .leading) {
                            Text("Hair I can Work on...")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                                .padding(.bottom, 20)
                            
                            Text("Hair Thickness")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                            
                            HStack(spacing: 10) {
                                ForEach(1...3, id: \.self) { number in
                                    Button(action: {
                                        selectHairThickness(number)
                                    }) {
                                        HorizontalButtonText(number == 1 ? "Fine" : number == 2 ? "Medium" : "Coarse", isSelected: selectedHairThicknesses.contains(number))
                                    }
                                }
                            }
                            
                            Text("Hair Type")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                            
                            HStack(spacing: 10) {
                                ForEach(4...6, id: \.self) { number in
                                    Button(action: {
                                        selectHairType(number)
                                    }) {
                                        HairTypeButton(number == 4 ? "Straight" : number == 5 ? "Wavy" : "Curly", number == 4 ? "straightHairIcon" : number == 5 ? "wavyHairIcon" : "curlyHairIcon", isSelected: selectedHairTypes.contains(number))
                                    }
                                }
                            }
                            .padding(.vertical, 10)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        Button(action: continueAction) {
                            Text("Continue")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(canContinue() ? Color.white : Color("PrimaryColor"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(canContinue() ? Color("PrimaryColor") : Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        }
                        .padding(.vertical)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text("Please make a selection."), dismissButton: .default(Text("OK")))
                        }
                        
                        NavigationLink("", destination: StylistCurlPatternScreenView().navigationBarHidden(true), isActive: $navigateToCurlPatternScreen)
                        NavigationLink("", destination: StylistCurlPatternScreenView().navigationBarHidden(true), isActive: $navigateToPreferenceScreen)
                    }
                    .padding()
                }
            }
        }
    }

    private func selectHairThickness(_ number: Int) {
        withAnimation {
            if let index = selectedHairThicknesses.firstIndex(of: number) {
                selectedHairThicknesses.remove(at: index)
            } else {
                selectedHairThicknesses.append(number)
            }
            viewModel.specialties = selectedHairThicknesses + selectedHairTypes
        }
    }

    private func selectHairType(_ number: Int) {
        withAnimation {
            if let index = selectedHairTypes.firstIndex(of: number) {
                selectedHairTypes.remove(at: index)
            } else {
                selectedHairTypes.append(number)
            }
            viewModel.specialties = selectedHairThicknesses + selectedHairTypes
        }
    }

    private func continueAction() {
        if canContinue() {
            navigateToCurlPatternScreen = true // Adjust logic if necessary
        } else {
            showingAlert = true
        }
    }

    private func canContinue() -> Bool {
        !selectedHairThicknesses.isEmpty && !selectedHairTypes.isEmpty
    }
}

struct StylistHairIDScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StylistHairIDScreenView().environmentObject(UserRegistrationViewModel())
    }
}

private func HorizontalButtonText(_ text: String, isSelected: Bool) -> some View {
    Text(text)
        .font(.body)
        .fontWeight(.bold)
        .foregroundColor(isSelected ? Color.white : Color("PrimaryColor"))
        .padding(8)
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 40)
        .background(isSelected ? Color("PrimaryColor") : Color.white.opacity(0.7))
        .cornerRadius(20.0)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
}

private func HairTypeButton(_ text: String, _ imageName: String, isSelected: Bool) -> some View {
    VStack {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
        HorizontalButtonText(text, isSelected: isSelected)
    }
}
