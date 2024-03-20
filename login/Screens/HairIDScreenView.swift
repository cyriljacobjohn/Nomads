//
//  HairIDScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 3/20/24.
//

import SwiftUI
import UIKit // For textboxes

struct HairIDScreenView: View {
    @State private var selectedHairThickness: Int? = nil
    @State private var selectedHairType: Int? = nil
    @State private var colorHistory: String = ""

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
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        self.selectedHairThickness = 1
                                    }
                                }) {
                                    HorizontalButtonText("Fine", isSelected: self.selectedHairThickness == 1)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        self.selectedHairThickness = 2
                                    }
                                }) {
                                    HorizontalButtonText("Medium", isSelected: self.selectedHairThickness == 2)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        self.selectedHairThickness = 3
                                    }
                                }) {
                                    HorizontalButtonText("Coarse", isSelected: self.selectedHairThickness == 3)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            
                            Text("Hair Type")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, -10)
                            
                            HStack(spacing: 10) {
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        self.selectedHairType = 1
                                    }
                                }) {
                                    VStack {
                                        Image("straightHairIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                        HorizontalButtonText("Straight", isSelected: self.selectedHairType == 1)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        self.selectedHairType = 2
                                    }
                                }) {
                                    VStack {
                                        Image("curlyHairIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                        HorizontalButtonText("Curly", isSelected: self.selectedHairType == 2)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        self.selectedHairType = 3
                                    }
                                }) {
                                    VStack {
                                        Image("wavyHairIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                        HorizontalButtonText("Wavy", isSelected: self.selectedHairType == 3)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.vertical, 10)
                            
                            Text("Color History")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, -5)

                            TextEditor(text: $colorHistory)
                                .frame(height: 90)
                                .padding(4)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(5.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                            
                            
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

struct HairIDScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HairIDScreenView()
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

// TODO: Validate to ensure not empty and send to backend
