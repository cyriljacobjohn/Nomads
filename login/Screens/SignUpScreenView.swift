//
//  SignInScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg 2/21/24.


import SwiftUI

struct SignUpScreenView: View {
    @EnvironmentObject var viewModel: UserRegistrationViewModel
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
                                .foregroundColor(.black)
                            
                            TextField("", text: $viewModel.email)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                                .padding(.bottom, 20)
                                .foregroundColor(.black)

                            Text("Password")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                                .foregroundColor(.black)
                            
                            SecureField("", text: $viewModel.password)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                                .padding(.bottom, 20)
                                .textContentType(.newPassword)
                                .foregroundColor(.black)

                            Text("Confirm Password")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                                .foregroundColor(.black)
                            
                            SecureField("", text: $confirmPassword)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .foregroundColor(.black)
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
                                .foregroundColor(viewModel.email.isEmpty || viewModel.password.isEmpty || confirmPassword.isEmpty ? Color("PrimaryColor") : Color.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(viewModel.email.isEmpty || viewModel.password.isEmpty || confirmPassword.isEmpty ? Color.white : Color("PrimaryColor"))
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                        }
                        .padding(.bottom, 10)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                        .animation(.easeInOut, value: viewModel.email.isEmpty || viewModel.password.isEmpty || confirmPassword.isEmpty)
                        
                        NavigationLink(destination: SignInScreenView().navigationBarHidden(true)) {
                            Text("Have An Account? ")
                                .foregroundColor(Color.black) +
                            Text("Sign In")
                                .foregroundColor(Color("PrimaryColor"))
                        }
                        .padding(.bottom, 20)

                        NavigationLink("", destination: AccountTypeSelectionView().navigationBarHidden(true), isActive: $shouldNavigateToNextScreen)
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

    private func handleSignUp() {
        if viewModel.email.isEmpty || viewModel.password.isEmpty || confirmPassword.isEmpty {
            alertMessage = "Please fill in all fields."
            showingAlert = true
        } else if viewModel.password != confirmPassword {
            alertMessage = "Passwords do not match."
            showingAlert = true
        } else {
            registerUser()
        }
    }

    private func registerUser() {
        viewModel.signUp { success in
            DispatchQueue.main.async {
                if success {
                    // Navigate to the next screen
                    shouldNavigateToNextScreen = true
                } else {
                    // Handle errors, e.g., show an alert
                    alertMessage = "User Registration failed."
                    showingAlert = true
                }
            }
        }
    }
}

struct SignUpScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreenView().environmentObject(UserRegistrationViewModel())
    }
}

private func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
