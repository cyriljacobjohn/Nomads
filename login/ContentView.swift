//
//  ContentView.swift
//  UMI
//
//  Created by Sebastian Oberg on 2/21/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showOnboarding: Bool = false
    @State private var isStylist: Bool = false
   
    var body: some View {
        
        if showOnboarding {
            OnboardingViewClient(showOnboarding: $showOnboarding)
        } else if isStylist {
            StylistTabView()  // Show the stylist interface if logged in as a stylist
        } else {
            MainTabView()     // Show the main client interface otherwise
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
