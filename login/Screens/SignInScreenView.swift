//
//  SignInScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg 2/21/24.
//

import SwiftUI

struct SignInScreenView: View {
    @StateObject private var userRegistrationVM = UserRegistrationViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var userType: String = ""  // Add this line
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

                        Spacer().frame(height: 40)

                        VStack(alignment: .leading) {
                            Text("Account Sign In")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                                .padding(.bottom, 20)

                            Text("Email")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                            
                            TextField("Enter Email", text: $email)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                                .padding(.bottom, 20)

                            Text("Password")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                            
                            SecureField("Enter Password", text: $password)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                                .padding(.bottom, 20)
                        }
                        .padding(.horizontal)

                        Spacer()

                        Button(action: handleSignIn) {
                            Text("Sign In")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(email.isEmpty || password.isEmpty ? Color("PrimaryColor") : Color.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(email.isEmpty || password.isEmpty ? Color.white : Color("PrimaryColor"))
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                        }
                        .padding(.bottom, 10)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }

                        NavigationLink(destination: SignUpScreenView().navigationBarHidden(true)) {
                            Text("New Here? ")
                                .foregroundColor(Color.black) +
                            Text("Sign Up")
                                .foregroundColor(Color("PrimaryColor"))
                        }
                        .padding(.bottom, 20)

                        // Conditional navigation based on user type
                        if userType == "client" {
                            NavigationLink("", destination: MainTabView().navigationBarHidden(true).navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                            NavigationLink("", destination: MainTabView().navigationBarHidden(true).navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                        } else if userType == "stylist" {
                            NavigationLink("", destination: StylistTabView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                        }
                    }
                    .padding()
                }
            }
        }
    }

    private func handleSignIn() {
        if email.isEmpty || password.isEmpty {
            alertMessage = "Please fill in all fields."
            showingAlert = true
        } else {
            userRegistrationVM.email = email
            userRegistrationVM.password = password
            userRegistrationVM.signIn { success, ayoStatus, user in
                if success {
                    DispatchQueue.main.async {
                        self.userType = user
                        self.shouldNavigateToNextScreen = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.alertMessage = "Authentication failed."
                        self.showingAlert = true
                    }
                }
            }
        }
    }
}

struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView()
    }
}
