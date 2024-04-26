//
//  loginApp.swift
//  UMI
//
//  Created by Sebastian Oberg on 2/21/24.
//

import SwiftUI

@main
struct UMIApp: App {
    @StateObject var userRegistrationViewModel = UserRegistrationViewModel()
    @StateObject var sessionManager = UserSessionManager.shared  // Create a StateObject for the session manager

    var body: some Scene {
        WindowGroup {
            WelcomeScreenView()
                .environmentObject(userRegistrationViewModel)  // Existing ViewModel
                .environmentObject(sessionManager)             // Session Manager
            // ContentView() // Uncomment this if you switch back to the ContentView in the future
        }
    }
}

