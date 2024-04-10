//
//  WelcomeScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 2/21/2024.
//

import SwiftUI

struct WelcomeScreenView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Text("UMI")
                        .font(.custom("Sarina-Regular", size: 60))
                        .foregroundColor(Color("PrimaryColor"))
                    Spacer()
                    
//                    NavigationLink(
////                        destination: SignUpScreenView().navigationBarHidden(false),
//                        destination: NameEntryScreenView().navigationBarHidden(false),
//                        label: {
//                            Text("Get Started")
//                                .font(.title3)
//                                .fontWeight(.bold)
//                                .foregroundColor(Color.white)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color("PrimaryColor"))
//                                .cornerRadius(50.0)
//                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
//                        })
                                
                    
                    NavigationLink(
                        destination: SignInScreenView().navigationBarHidden(false),
                        label: {
                            Text("Sign In")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color("PrimaryColor"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                                .padding(.vertical)
                        })
                }
                .padding()
            }
        }
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}
