//
//  SignUpVerificationScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 3/29/24.
//

import SwiftUI

struct SignUpVerificationScreenView: View {
    @State private var otpCode: String = ""
    @State private var isOTPValid = false
    let correctOTP = "123456"  // This should ideally come from backend after sending an SMS

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
                        Text("Phone Verification")
                            .font(.custom("Sansita-BoldItalic", size: 50))
                            .foregroundColor(Color("TitleTextColor"))
                            .padding(.bottom, 20)
                        
                        TextField("Enter OTP Code", text: $otpCode)
                            .keyboardType(.numberPad)
                            .padding(EdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24))
                            .background(Color.white)
                            .cornerRadius(25.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                            .padding(.horizontal)
                            .onChange(of: otpCode) { newValue in
                                isOTPValid = newValue == correctOTP
                            }
                        
                        if otpCode.count == 6 && !isOTPValid {
                            Text("Incorrect Code. Please try again.")
                                .foregroundColor(Color.red)
                                .padding(.top, 5)
                        }
                        
                        NavigationLink(destination: NameEntryScreenView().navigationBarBackButtonHidden(true), isActive: $isOTPValid) {
                            Text("Next")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(otpCode.count == 6 ? Color.white : Color("PrimaryColor"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(otpCode.count == 6 ? Color("PrimaryColor") : Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                                .padding(.vertical)
                        }
                        .disabled(!isOTPValid)
                        Spacer()
                    }
                    VStack {
                        NavigationLink(destination: SignInScreenView().navigationBarHidden(true)) {
                            Text("Havent received a code? ")
                                .foregroundColor(Color.black) +
                            Text("Resend")
                                .foregroundColor(Color("PrimaryColor"))
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct SignUpVerificationScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpVerificationScreenView()
    }
}
