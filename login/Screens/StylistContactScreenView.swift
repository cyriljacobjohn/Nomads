//
//  StylistContactScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 4/4/24.
//

import SwiftUI

struct StylistContactScreenView: View {
    @State private var instagram: String = ""
    @State private var twitter: String = ""
    @State private var linkedTree: String = ""
    @State private var shouldNavigateToNextScreen = false
    @State private var showingAlert = false
    @State private var phoneNumRaw: String = ""
    var phoneNum: Binding<String> {
        Binding<String>(
            get: { self.phoneNumRaw },
            set: { self.phoneNumRaw = $0 }
        )
    }
    
    @State private var selectedCode = CountryCode(id: 0, code: "+1", countryName: "US")
    let countryCodes: [CountryCode] = [
        CountryCode(id: 0, code: "+1", countryName: "US"),
        CountryCode(id: 1, code: "+91", countryName: "IN"),
        // Other country codes...
    ]

    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack {
                        Text("UMI")
                            .font(.custom("Sarina-Regular", size: 35))
                            .foregroundColor(Color("PrimaryColor"))

                        Spacer().frame(height: 30)
                        
                        VStack(alignment: .leading) {
                            Text("Contact Information")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                                .padding(.bottom, 10)
                            
                            Text("Phone Number")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 10)
                            
                            HStack {
                                Menu {
                                    Picker("Select your country", selection: $selectedCode) {
                                        ForEach(countryCodes, id: \.id) { code in
                                            Text("\(code.countryName) (\(code.code))").tag(code)
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(selectedCode.code)
                                            .foregroundColor(.black)
                                        Image(systemName: "arrowtriangle.down.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 10, height: 5)
                                            .foregroundColor(.black)
                                    }
                                    .padding(EdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24))
                                    .background(Color.white)
                                    .cornerRadius(25.0)
                                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                                }
                                
                                TextField("123456789", text: phoneNum)
                                    .keyboardType(.numberPad)
                                    .padding(EdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24))
                                    .background(Color.white)
                                    .cornerRadius(25.0)
                                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                            }

                            contactField("Instagram", text: $instagram)
                            contactField("Twitter", text: $twitter)
                            contactField("LinkedTree", text: $linkedTree)
                        }
                        .padding(.horizontal)

                        Button(action: continueAction) {
                            Text("Continue")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(canContinue ? Color.white : Color("PrimaryColor"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(canContinue ? Color("PrimaryColor") : Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                        }
                        .padding(.vertical)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text(errorAlertMessage()), dismissButton: .default(Text("OK")))
                        }
                        NavigationLink("", destination: StylistSpecialtyScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                    }
                    .padding()
                }
            }
        }
    }

    private var canContinue: Bool {
        !instagram.isEmpty && !twitter.isEmpty && !linkedTree.isEmpty && phoneNumRaw.count == 10
    }

    private func continueAction() {
        if canContinue {
            sendDataToBackend()
            shouldNavigateToNextScreen = true
        } else {
            showingAlert = true
        }
    }

    private func errorAlertMessage() -> String {
        if instagram.isEmpty || twitter.isEmpty || linkedTree.isEmpty {
            return "Please fill in all contact fields."
        } else if phoneNumRaw.count != 9 {
            return "Enter complete phone number."
        } else {
            return "Error in input."
        }
    }

    private func sendDataToBackend() {
        print("Sending contacts to backend: Instagram: \(instagram), Twitter: \(twitter), LinkedTree: \(linkedTree), Phone: \(selectedCode.code)\(phoneNumRaw)")
        // Implement your backend communication logic here
    }

    private func contactField(_ label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                .padding(.bottom, 10)

            TextField(label, text: text)
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(50.0)
                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                .padding(.top, -8)
                .padding(.bottom, 10)
        }
    }
}

struct CountryCode: Identifiable, Hashable {
    let id: Int
    let code: String
    let countryName: String
}

struct StylistContactScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StylistContactScreenView()
    }
}
