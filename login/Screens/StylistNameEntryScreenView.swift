//
//  StylistNameEntryScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 4/4/24.
//

import SwiftUI

struct StylistNameEntryScreenView: View {
    @EnvironmentObject var viewModel: UserRegistrationViewModel
    @State private var shouldNavigateToNextScreen = false
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        Text("UMI")
                            .font(.custom("Sarina-Regular", size: 35))
                            .foregroundColor(Color("PrimaryColor"))
                        
                        Spacer().frame(height: 20)
                        
                        VStack(alignment: .leading) {
                            Text("Let's Get")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                            
                            Text("Started")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                                .padding(.bottom, 20)

                            Text("First Name")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                                .foregroundColor(.black)
                            
                            TextField("", text: $viewModel.firstName)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                                .padding(.top, -8)
                                .padding(.bottom, 20)
                                .foregroundColor(.black)

                            Text("Last Name")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                                .foregroundColor(.black)
                            
                            TextField("", text: $viewModel.lastName)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                                .padding(.top, -8)
                                .padding(.bottom, 20)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    Button(action: continueAction) {
                        Text("Continue")
                            .font(.title3)
                            .foregroundColor(viewModel.firstName.isEmpty || viewModel.lastName.isEmpty ? Color("PrimaryColor") : Color.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(viewModel.firstName.isEmpty || viewModel.lastName.isEmpty ? Color.white : Color("PrimaryColor"))
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                    }
                    .padding(.vertical)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text("Please fill in all fields."), dismissButton: .default(Text("OK")))
                    }
                    .animation(.easeInOut, value: viewModel.firstName.isEmpty || viewModel.lastName.isEmpty)


                    NavigationLink("", destination: StylistAddressScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                }
                .padding()
            }
            .onTapGesture
            {
                hideKeyboard()  // Call to dismiss the keyboard
            }
        }
    }

    private func continueAction() {
        if viewModel.firstName.isEmpty || viewModel.lastName.isEmpty {
            showingAlert = true
        } else {
            shouldNavigateToNextScreen = true
        }
    }
}

struct StylistNameEntryScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StylistNameEntryScreenView().environmentObject(UserRegistrationViewModel())
    }
}

private func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
