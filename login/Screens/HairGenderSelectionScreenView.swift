//
//  HairGenderSelectionScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 3/19/24.
//

import SwiftUI

struct HairGenderSelectionScreenView: View {
    @State private var selectedButton: Int? = nil

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
                            Text("My Hair Is...")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                            
                            // Button 1
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    self.selectedButton = 1
                                }
                            }) {
                                buttonText("Feminine", isSelected: self.selectedButton == 1)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.bottom, -15)
                            
                            // Button 2
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    self.selectedButton = 2
                                }
                            }) {
                                buttonText("Masculine", isSelected: self.selectedButton == 2)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.bottom, -15)
                            
                            // Button 3
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    self.selectedButton = 3
                                }
                            }) {
                                buttonText("Androgynous", isSelected: self.selectedButton == 3)
                            }
                            .buttonStyle(PlainButtonStyle())

                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    NavigationLink( // Back already included for navigation links
//                        destination: NameEntryScreenView().navigationBarHidden(true),
                        destination: HairIDScreenView().navigationBarHidden(true),
                        label: {
                            Text("Continue")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color("PrimaryColor"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                                .padding(.vertical)
                        })
                }
                .padding()
            }
        }
    }
}

struct HairGenderSelectionScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HairGenderSelectionScreenView()
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
