//
//  CurlPatternScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 3/30/24.
//


import SwiftUI

struct ClientCurlPatternScreenView: View {
    @State private var selectedCurlPattern: Int? = nil
    @State private var shouldNavigateToNextScreen = false
    @State private var showingAlert = false

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
                            Text("Curl Pattern Selection")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                                .padding(.bottom, 20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Select one:")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 10)
                        }

                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(curlPatterns, id: \.1) { pattern in
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        self.selectedCurlPattern = pattern.1
                                    }
                                }) {
                                    buttonText(pattern.0, isSelected: self.selectedCurlPattern == pattern.1)
                                }
                                .padding(.bottom)
                            }
                        }
                        .padding(.horizontal)

                        Button(action: continueAction) {
                            Text("Continue")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(selectedCurlPattern != nil ? Color.white : Color("PrimaryColor"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(selectedCurlPattern != nil ? Color("PrimaryColor") : Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        }
                        .padding(.vertical)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text("Please make a selection."), dismissButton: .default(Text("OK")))
                        }
                    }
                    .padding()
                    
                    NavigationLink("", destination: ClientPreferenceScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                }
            }
        }
    }

    private func continueAction() {
        if selectedCurlPattern == nil {
            showingAlert = true
        } else {
            sendDataToBackend()
            shouldNavigateToNextScreen = true
        }
    }

    private func sendDataToBackend() {
        // Implement the actual backend call here
        print("Sending selected curl pattern to backend: \(String(describing: selectedCurlPattern))")
    }
}

struct ClientCurlPatternScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ClientCurlPatternScreenView()
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
