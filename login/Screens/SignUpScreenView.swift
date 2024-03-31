//
//  SignInScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg 2/21/24.


import SwiftUI

struct SignUpScreenView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
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
                            Text("Create An Account")
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

                            Text("Confirm Password")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                            
                            SecureField("Confirm Password", text: $confirmPassword)
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

                        Button(action: handleSignUp) {
                            Text("Sign Up")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(email.isEmpty || password.isEmpty || confirmPassword.isEmpty ? Color("PrimaryColor") : Color.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(email.isEmpty || password.isEmpty || confirmPassword.isEmpty ? Color.white : Color("PrimaryColor"))
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                        }
                        .padding(.bottom, 10)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }

                        NavigationLink(destination: SignInScreenView().navigationBarHidden(true)) {
                            Text("Already registered? ")
                                .foregroundColor(Color.black) +
                            Text("Sign in")
                                .foregroundColor(Color("PrimaryColor"))
                        }
                        .padding(.bottom, 20)

                        NavigationLink("", destination: NameEntryScreenView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
                    }
                    .padding()
                }
            }
        }
    }

    private func handleSignUp() {
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            alertMessage = "Please fill in all fields."
            showingAlert = true
        } else if password != confirmPassword {
            alertMessage = "Passwords do not match."
            showingAlert = true
        } else {
            registerUser()
            shouldNavigateToNextScreen = true
        }
    }

    private func registerUser() {
        // Implement registration logic here, communicate with backend
        print("Sending data to backend: Email: \(email), Password: \(password)")
    }
}

struct SignUpScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreenView()
    }
}
