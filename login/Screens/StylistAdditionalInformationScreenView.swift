//
//  StylistAdditionalInformationScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 4/4/24.
//

import SwiftUI

struct StylistAdditionalInformationScreenView: View {
    @EnvironmentObject var viewModel: UserRegistrationViewModel
    @State private var navigateToCurlPatternScreen = false
    @State private var shouldNavigateToNextScreen = false
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        VStack {
                            Text("UMI")
                                .font(.custom("Sarina-Regular", size: 35))
                                .foregroundColor(Color("PrimaryColor"))
                            
                            Spacer().frame(height: 40)
                            
                            VStack(alignment: .leading) {
                                Text("Information for Clients")
                                    .font(.custom("Sansita-BoldItalic", size: 50))
                                    .foregroundColor(Color("TitleTextColor"))
                                    .padding(.bottom, 20)
                                
                                Text("Describe any details clients should know")
                                    .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                    .padding(.bottom, 10)
                                
                                TextEditor(text: $viewModel.stylistsShouldKnow)
                                    .frame(height: 200)
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
                                .foregroundColor(!viewModel.stylistsShouldKnow.isEmpty ? Color.white : Color("PrimaryColor"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(!viewModel.stylistsShouldKnow.isEmpty ? Color("PrimaryColor") : Color.white.opacity(0.7))
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        }
                        .padding(.vertical)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text("Please provide the requested information."), dismissButton: .default(Text("OK")))
                        }
                        
                        NavigationLink("", destination: StylistTabView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                    }
                    .padding()
                }
            }
        }
    }

    private func continueAction() {
        if viewModel.stylistsShouldKnow.isEmpty {
            showingAlert = true
        } else {
            viewModel.createStylistAccount { success in
                if success {
                    // Navigate to the next screen or show success message
                    shouldNavigateToNextScreen = true
                } else {
                    // Handle the error, show an alert or retry mechanism
                    showingAlert = true
                }
            }
        }
    }
}

struct StylistAdditionalInformationScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StylistAdditionalInformationScreenView().environmentObject(UserRegistrationViewModel())
    }
}
