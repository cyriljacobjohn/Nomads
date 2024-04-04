//
//  stylist-client.swift
//  UMI
//
//  Created by Cyril John on 3/29/24.
//

import Foundation
import SwiftUI

struct AccountTypeSelectionView: View {
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
                            Text("My Account Type")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                            
                            // Button 1
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    self.selectedButton = 1
                                }
                            }) {
                                buttonText("Client", isSelected: self.selectedButton == 1)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.bottom, -15)
                            
                            // Button 2
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    self.selectedButton = 2
                                }
                            }) {
                                buttonText("Stylist", isSelected: self.selectedButton == 2)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.bottom, -15)
                            
                            // Button 3
                            

                        }
                        .padding(.horizontal)
                    }

                    Spacer()
                    
                    NavigationLink( // Back already included for navigation links
//                        destination: NameEntryScreenView().navigationBarHidden(true),
                        destination: HairGenderSelectionScreenView().navigationBarHidden(true),
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

struct AccountTypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AccountTypeSelectionView()
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
