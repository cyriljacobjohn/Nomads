//
//  SignUpScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 3/1/24.
//

import SwiftUI

struct SignUpScreenView: View {
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                SocalLoginButton(image: Image(uiImage: #imageLiteral(resourceName: "apple")), text: Text("Sign up with Apple"))
                
                SocalLoginButton(image: Image(uiImage: #imageLiteral(resourceName: "google")), text: Text("Sign up with Google").foregroundColor(Color("PrimaryColor")))
                    .padding(.vertical)
            }
            .padding()
        }
    }
}

struct SignUpScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreenView()
    }
}
