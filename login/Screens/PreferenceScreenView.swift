//
//  PreferenceScreenView.swift
//  UMI
//
//  Created by Cyril John on 3/30/24.
//

import SwiftUI
import UIKit // For textboxes


struct PreferenceScreenView: View {
    
    @State private var selectedHairStyles: [String: Bool] = [
            "Fades": false,
            "Long Hair Cuts": false,
            "Color Services": false,
            "Braids": false,
            "Alternative Cuts": false
        ]

    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                
                ScrollView{
                    VStack {
                        VStack {
                            Text("UMI")
                                .font(.custom("Sarina-Regular", size: 35))
                                .foregroundColor(Color("PrimaryColor"))
                            
                            Spacer().frame(height: 40)
                            
                            VStack(alignment: .leading) {
                                Text("I'm looking")
                                    .font(.custom("Sansita-BoldItalic", size: 50))
                                    .foregroundColor(Color("TitleTextColor"))
                                
                                Text("for")
                                    .font(.custom("Sansita-BoldItalic", size: 50))
                                    .foregroundColor(Color("TitleTextColor"))
                                    .padding(.bottom, 20)
                                
                                Text("Select all that apply")
                                    .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                    .padding(.bottom, 20)

                                
                                HStack(spacing: 10) {
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            selectedHairStyles["Fades"]?.toggle()
                                        }
                                    }) {
                                        HorizontalButtonText("Fades", isSelected: selectedHairStyles["Fades"] ?? false, icon: "high-fade-light" )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            selectedHairStyles["Braids"]?.toggle()
                                        }
                                    }) {
                                        HorizontalButtonText("Braids", isSelected: selectedHairStyles["Braids"] ?? false, icon:"braids")
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                }
    
                    
                                HStack(spacing: 10) {
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            selectedHairStyles["Long Hair Cuts"]?.toggle()
                                        }
                                    }) {
                                        HorizontalButtonText("Long Haircuts", isSelected: selectedHairStyles["Long Hair Cuts"] ?? false, icon: "long-hair")
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            selectedHairStyles["Color Services"]?.toggle()
                                        }
                                    }) {
                                        HorizontalButtonText("Color Services", isSelected: selectedHairStyles["Color Services"] ?? false, icon: "hair-color")
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                }
                             
                                
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            selectedHairStyles["Alternative Cuts"]?.toggle()
                                        }
                                    }) {
                                        HorizontalButtonText("Alternative Cuts", isSelected:selectedHairStyles["Alternative Cuts"] ?? false, icon: "alternative-cuts")
                                    }
                                    .buttonStyle(PlainButtonStyle())
                
                            }
                            .padding(.horizontal)
                        }
                        
                        Spacer()
                        
                        NavigationLink(
                            destination: Text("Next Screen Placeholder").navigationBarHidden(true),
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
}

struct PreferencesScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceScreenView()
    }
}

private func HorizontalButtonText(_ text: String, isSelected: Bool, icon: String) -> some View {
    VStack {
        Image(icon) // Assuming `icon` is the name of the image
            .resizable()
            .padding(10)
            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100) // Adjust the size as needed

        Text(text)
            .font(.custom("Poppins-SemiBold", size: 20))
            .foregroundColor(isSelected ? Color.white : Color("PrimaryColor"))
            .padding(8)
            .frame(alignment: .center)
    }
    .frame(minWidth: 0, maxWidth: 150, maxHeight: 200, alignment: .center)
    .background(isSelected ? Color("PrimaryColor") : Color.white.opacity(0.7))
    .cornerRadius(20.0)
    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
    .padding(.vertical, 5)
}

