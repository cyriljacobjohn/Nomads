//
//  StylistCurlPatternScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 4/9/24.
//

import SwiftUI

struct StylistCurlPatternScreenView: View {
    @EnvironmentObject var viewModel: UserRegistrationViewModel
    @State private var shouldNavigateToNextScreen = false
    @State private var showingAlert = false
    @State private var selectedCurlPatterns: [Int] = []

    let curlPatterns = [
        ("2A", 10),
        ("2B", 11),
        ("2C", 12),
        ("3A", 13),
        ("3B", 14),
        ("3C", 15),
        ("4A", 16),
        ("4B", 17),
        ("4C", 18)
    ]

    private var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 15), count: 2)
    }

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

                        VStack(alignment: .leading) {
                            Text("Curl Patterns I Can Work With")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                                .padding(.bottom, 20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Select one or more:")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 10)
                        }

                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(curlPatterns, id: \.1) { pattern in
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        updateCurlPatternSelection(with: pattern.1)
                                    }
                                }) {
                                    buttonText(pattern.0, isSelected: selectedCurlPatterns.contains(pattern.1))
                                }
                                .padding(.bottom)
                            }
                        }
                        .padding(.horizontal)

                        Button(action: continueAction) {
                            Text("Continue")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(selectedCurlPatterns.isEmpty ? Color("PrimaryColor") : Color.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(selectedCurlPatterns.isEmpty ? Color.white : Color("PrimaryColor"))
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        }
                        .padding(.vertical)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text("Please make a selection."), dismissButton: .default(Text("OK")))
                        }
                    }
                    .padding()
                    
                    NavigationLink("", destination: StylistSpecialtyScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                }
            }
        }
    }

    private func updateCurlPatternSelection(with pattern: Int) {
        if let index = selectedCurlPatterns.firstIndex(of: pattern) {
            selectedCurlPatterns.remove(at: index)
        } else {
            selectedCurlPatterns.append(pattern)
        }
        viewModel.specialties = selectedCurlPatterns
    }

    private func continueAction() {
        if selectedCurlPatterns.isEmpty {
            showingAlert = true
        } else {
            shouldNavigateToNextScreen = true
        }
    }
}

struct StylistCurlPatternScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StylistCurlPatternScreenView().environmentObject(UserRegistrationViewModel())
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
}
