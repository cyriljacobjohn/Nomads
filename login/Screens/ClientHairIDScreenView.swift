//
//  HairIDScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 3/20/24.
//

import SwiftUI

struct ClientHairIDScreenView: View {
    @State private var selectedHairThickness: Int? = nil
    @State private var selectedHairType: Int? = nil
    @State private var colorHistory: String = "None"
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
                            Text("Build Your")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                            
                            Text("Hair ID")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                                .padding(.bottom, 20)

                            Text("Hair Thickness")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, -10)
                            
                            HStack(spacing: 10) {
                                Button(action: { selectHairThickness(1) }) {
                                    HorizontalButtonText("Fine", isSelected: self.selectedHairThickness == 1)
                                }
                                
                                Button(action: { selectHairThickness(2) }) {
                                    HorizontalButtonText("Medium", isSelected: self.selectedHairThickness == 2)
                                }
                                
                                Button(action: { selectHairThickness(3) }) {
                                    HorizontalButtonText("Coarse", isSelected: self.selectedHairThickness == 3)
                                }
                            }
                            
                            Text("Hair Type")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, -10)
                            
                            HStack(spacing: 10) {
                                Button(action: { selectHairType(1) }) {
                                    HairTypeButton("Straight", "straightHairIcon", isSelected: self.selectedHairType == 1)
                                }
                                
                                Button(action: { selectHairType(2) }) {
                                    HairTypeButton("Curly", "curlyHairIcon", isSelected: self.selectedHairType == 2)
                                }
                                
                                Button(action: { selectHairType(3) }) {
                                    HairTypeButton("Wavy", "wavyHairIcon", isSelected: self.selectedHairType == 3)
                                }
                            }
                            .padding(.vertical, 10)
                            
                            Text("Color History")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, -5)

                            TextEditor(text: $colorHistory)
                                .frame(height: 90)
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
                            .foregroundColor(selectedHairThickness != nil && selectedHairType != nil && !colorHistory.isEmpty ? Color.white : Color("PrimaryColor"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedHairThickness != nil && selectedHairType != nil && !colorHistory.isEmpty ? Color("PrimaryColor") : Color.white)
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    }
                    .padding(.vertical)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text("Please fill in all fields."), dismissButton: .default(Text("OK")))
                    }

                    NavigationLink("", destination: ClientCurlPatternScreenView().navigationBarHidden(true), isActive: $navigateToCurlPatternScreen)
                    NavigationLink("", destination: ClientPreferenceScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                }
                .padding()
            }
        }
    }

    private func selectHairThickness(_ thickness: Int) {
        withAnimation(.easeInOut(duration: 0.2)) {
            self.selectedHairThickness = thickness
        }
    }

    private func selectHairType(_ type: Int) {
        withAnimation(.easeInOut(duration: 0.2)) {
            self.selectedHairType = type
        }
    }

    private func continueAction() {
        if selectedHairThickness == nil || selectedHairType == nil || colorHistory.isEmpty {
            showingAlert = true
        } else {
            if selectedHairType == 2 || selectedHairType == 3 { // Assuming 2 and 3 represent Curly and Wavy
                navigateToCurlPatternScreen = true
            } else {
                sendDataToBackendForStraightHair()
                shouldNavigateToNextScreen = true
            }
        }
    }

    private func sendDataToBackendForStraightHair() {
        // This method is called when the selected hair type is Straight (none or 0)
        print("Sending curl pattern for straight hair to backend: none or 0")
        // Implement the actual backend call here
    }
}

struct ClientHairIDScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ClientHairIDScreenView()
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
        .padding(.vertical, 5)
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
