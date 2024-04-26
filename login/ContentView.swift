//
//  ContentView.swift
//  UMI
//
//  Created by Sebastian Oberg on 2/21/24.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
   
    var body: some View {
        WelcomeScreenView()
            .environmentObject(UserSessionManager.shared) // Ensure it's passed down to WelcomeScreenView if needed there
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserSessionManager.shared) // For previews
            .environmentObject(UserRegistrationViewModel()) // For previews, if used
    }
}

struct PrimaryButton: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor"))
            .cornerRadius(50)
    }
}

//struct ContentView: View {
//   
//    var body: some View {
//        WelcomeScreenView()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(UserRegistrationViewModel())
//    }
//}
//
//struct PrimaryButton: View {
//    var title: String
//    var body: some View {
//        Text(title)
//            .font(.title3)
//            .fontWeight(.bold)
//            .foregroundColor(.white)
//            .frame(maxWidth: .infinity)
//            .padding()
//            .background(Color("PrimaryColor"))
//            .cornerRadius(50)
//    }
//}
//
//  ContentView.swift
//  UMI
//
//  Created by Sebastian Oberg on 2/21/24.
//
//
//import SwiftUI
//
//struct ContentView: View {
//    
//    @State private var showOnBoarding: Bool = true
//    
//   
//    var body: some View {
//        if showOnBoarding{
//            OnboardingViewClient(showOnboarding: $showOnBoarding)
//        }
//        else{
//            MainTabView()
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//struct PrimaryButton: View {
//    var title: String
//    var body: some View {
//        Text(title)
//            .font(.title3)
//            .fontWeight(.bold)
//            .foregroundColor(.white)
//            .frame(maxWidth: .infinity)
//            .padding()
//            .background(Color("PrimaryColor"))
//            .cornerRadius(50)
//    }
//}
