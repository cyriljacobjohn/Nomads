//
//  HairIDScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 3/20/24.
//

import SwiftUI

struct ClientHairIDScreenView: View {
    @EnvironmentObject var viewModel: UserRegistrationViewModel
    @State private var navigateToCurlPatternScreen = false
    @State private var navigateToPreferenceScreen = false
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        Text("UMI")
                            .font(.custom("Sarina-Regular", size: 35))
                            .foregroundColor(Color("PrimaryColor"))
                        
                        Spacer().frame(height: 40)
                        
                        VStack(alignment: .leading) {
                            Text("Build Your")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                            
                            Text("Hair ID")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                                .padding(.bottom, 20)
                            
                            Text("Hair Thickness")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                            
                            HStack(spacing: 10) {
                                Button(action: {
                                    viewModel.hairProfile.thickness = 1
                                }) {
                                    HorizontalButtonText("Fine", isSelected: viewModel.hairProfile.thickness == 1)
                                }
                                
                                Button(action: {
                                    viewModel.hairProfile.thickness = 2
                                }) {
                                    HorizontalButtonText("Medium", isSelected: viewModel.hairProfile.thickness == 2)
                                }
                                
                                Button(action: {
                                    viewModel.hairProfile.thickness = 3
                                }) {
                                    HorizontalButtonText("Coarse", isSelected: viewModel.hairProfile.thickness == 3)
                                }
                            }
                            
                            Text("Hair Type")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                            
                            HStack(spacing: 10) {
                                Button(action: {
                                    viewModel.hairProfile.hairType = 4 // Straight hair
                                }) {
                                    HairTypeButton("Straight", "straightHairIcon", isSelected: viewModel.hairProfile.hairType == 4)
                                }
                                
                                Button(action: {
                                    viewModel.hairProfile.hairType = 6 // Curly hair
                                }) {
                                    HairTypeButton("Curly", "curlyHairIcon", isSelected: viewModel.hairProfile.hairType == 6)
                                }
                                
                                Button(action: {
                                    viewModel.hairProfile.hairType = 5 // Wavy hair
                                }) {
                                    HairTypeButton("Wavy", "wavyHairIcon", isSelected: viewModel.hairProfile.hairType == 5)
                                }
                            }
                            .padding(.vertical, 10)
                            
                            Text("Color History")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                            
                            TextEditor(text: $viewModel.hairProfile.colorHist)
                                .frame(height: 90)
                                .padding(4)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(10.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        Button(action: continueAction) {
                            Text("Continue")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(viewModel.hairProfile.isValid() ? Color.white : Color("PrimaryColor"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(viewModel.hairProfile.isValid() ? Color("PrimaryColor") : Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        }
                        .padding(.vertical)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text("Please fill in all fields."), dismissButton: .default(Text("OK")))
                        }
                        
                        NavigationLink("", destination: ClientCurlPatternScreenView().navigationBarHidden(true), isActive: $navigateToCurlPatternScreen)
                        NavigationLink("", destination: ClientPreferenceScreenView().navigationBarHidden(true), isActive: $navigateToPreferenceScreen)
                    }
                    .padding()
                }
            }
        }
    }

    private func continueAction() {
        if !viewModel.hairProfile.isValid() {
            showingAlert = true
        } else {
            if viewModel.hairProfile.hairType == 4 {
                navigateToPreferenceScreen = true
            } else {
                navigateToCurlPatternScreen = true
            }
        }
    }
}

struct ClientHairIDScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ClientHairIDScreenView().environmentObject(UserRegistrationViewModel())
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
