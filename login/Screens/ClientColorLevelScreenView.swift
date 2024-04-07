//
//  ClientColorLevelScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 4/6/24.
//

import SwiftUI

struct ClientColorLevelScreenView: View {
    @State private var colorLevel: Double = 1
    @State private var shouldNavigateToNextScreen = false
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("UMI")
                        .font(.custom("Sarina-Regular", size: 35))
                        .foregroundColor(Color("PrimaryColor"))

                    Spacer().frame(height: 40)
                    
                    VStack(alignment: .leading) {
                        Text("How Dark Is Your Hair?")
                            .font(.custom("Sansita-BoldItalic", size: 50))
                            .foregroundColor(Color("TitleTextColor"))
                            .padding(.bottom, 20)
                        
                        Text("Select hair color level: \n1 (darkest) to 10 (lightest)")
                            .font(.custom("Poppins-SemiBoldItalic", size: 20))
                            .padding(.bottom, 10)
                        
                        Slider(value: $colorLevel, in: 1...10, step: 1)
                            .padding(.bottom, 10)

                        Text("My hair is a \(Int(colorLevel)).")
                            .font(.custom("Poppins-Italic", size: 18))
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal)
                    
                    Spacer()

                    Button(action: continueAction) {
                        Text("Continue")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    }
                    .padding(.vertical)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text("Please set an average price."), dismissButton: .default(Text("OK")))
                    }

                    NavigationLink("", destination: ClientAdditionalInformationScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                }
                .padding()
            }
        }
    }

    private func continueAction() {
        if colorLevel == 0 {
            showingAlert = true
        } else {
            sendDataToBackend()
            shouldNavigateToNextScreen = true
        }
    }

    private func sendDataToBackend() {
        print("Sending color level to backend: \(colorLevel)")
    }
}

struct ClientColorLevelScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ClientColorLevelScreenView()
    }
}
