//
//  StylistPriceScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 4/4/24.
//

// StylistPriceScreenView.swift
import SwiftUI

struct StylistPriceScreenView: View {
    @EnvironmentObject var viewModel: UserRegistrationViewModel
    @State private var averagePrice: Double = 25
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
                        Text("What's your average price?")
                            .font(.custom("Sansita-BoldItalic", size: 50))
                            .foregroundColor(Color("TitleTextColor"))
                            .padding(.bottom, 20)
                        
                        Slider(value: $averagePrice, in: 0...200, step: 1)
                            .padding(.bottom, 20)
                        Text(String(format: "$%.0f", averagePrice))
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

                    NavigationLink("", destination: StylistContactScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                }
                .padding()
            }
        }
    }

    private func continueAction() {
        if averagePrice == 0 {
            showingAlert = true
        } else {
            viewModel.avgPrice = Int(averagePrice)
            shouldNavigateToNextScreen = true
        }
    }
}

struct StylistPriceScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StylistPriceScreenView().environmentObject(UserRegistrationViewModel())
    }
}
