//
//  ClientAdditionalInformation.swift
//  UMI
//
//  Created by Sebastian Oberg on 4/3/24.
//

import SwiftUI

struct ClientAdditionalInformationScreenView: View {
    @EnvironmentObject var viewModel: UserRegistrationViewModel
    @State private var shouldNavigateToNextScreen = false
    @State private var showingAlert = false
    @State private var alertMessage = ""

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
                        
                        Spacer().frame(height: 40)
                        
                        VStack(alignment: .leading) {
                            Text("Share Your Preferences")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                                .padding(.bottom, 20)
                            
                            Text("Let us know your preferences and any accessibility needs you have")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                                .foregroundColor(.black)
                            
                            TextEditor(text: $viewModel.stylistsShouldKnow)
                                .frame(height: 300)
                                .padding(4)
                                .background(Color.white)
                                .cornerRadius(10.0)
                                .foregroundColor(.black)
                                .environment(\.colorScheme, .light)
                        }
                        .padding(.horizontal)
                        
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
                            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                        .animation(.easeInOut, value: !viewModel.stylistsShouldKnow.isEmpty)
                        
                        NavigationLink("", destination: MainTabView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                        
                    }
                    .padding()
                }
                .onTapGesture
                {
                    hideKeyboard()  // Call to dismiss the keyboard
                }
            }
        }
    }

    private func continueAction() {
        if viewModel.stylistsShouldKnow.isEmpty {
            alertMessage = "Please fill in all fields."
            showingAlert = true
        } else {
            viewModel.createClientAccount { success in
                DispatchQueue.main.async {
                    if success {
                        shouldNavigateToNextScreen = true
                    } else {
                        alertMessage = "Could not create client account."
                        showingAlert = true
                    }
                }
            }
        }
    }
}

struct ClientAdditionalInformationScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ClientAdditionalInformationScreenView().environmentObject(UserRegistrationViewModel())
    }
}

private func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
