//
//  AccountTypeSelectionView.swift
//  UMI
//
//  Created by Cyril John on 3/29/24.
//

import SwiftUI

struct AccountTypeSelectionView: View {
    @EnvironmentObject var viewModel: UserRegistrationViewModel
    @State private var selectAccountType: Int? = nil
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
                    
                    Text("What's Your Account Type?")
                        .font(.custom("Sansita-BoldItalic", size: 50))
                        .foregroundColor(Color("TitleTextColor"))
                    
                    Button(action: { selectAccountType(1) }) {
                        buttonText("Client", isSelected: self.selectAccountType == 1)
                    }
                    .padding(.bottom, -15)
                    
                    Button(action: { selectAccountType(2) }) {
                        buttonText("Stylist", isSelected: self.selectAccountType == 2)
                    }
                    .padding(.bottom, -15)

                    Spacer()
                    
                    Button(action: continueAction) {
                        Text("Continue")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(selectAccountType == nil ? Color("PrimaryColor") : Color.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectAccountType == nil ? Color.white : Color("PrimaryColor"))
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    }
                    .padding(.vertical)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text("Please make a selection."), dismissButton: .default(Text("OK")))
                    }

                    // Conditional NavigationLink based on account type selection
                    if selectAccountType == 1 {
                        NavigationLink(destination: ClientNameEntryScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen) {
                            EmptyView()
                        }
                    } else if selectAccountType == 2 {
                        NavigationLink(destination: StylistNameEntryScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen) {
                            EmptyView()
                        }
                    }
                }
                .padding()
            }
        }
    }

    private func selectAccountType(_ accountType: Int) {
        withAnimation {
            self.selectAccountType = accountType
            viewModel.isStylist = (accountType == 2)
        }
    }

    private func continueAction() {
        if selectAccountType == nil {
            showingAlert = true
        } else {
            shouldNavigateToNextScreen = true
        }
    }
}

struct AccountTypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AccountTypeSelectionView().environmentObject(UserRegistrationViewModel())
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
