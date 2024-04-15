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

    var body: some Scene {
        WindowGroup {
            WelcomeScreenView()
                .environmentObject(userRegistrationViewModel)
//            ContentView()
        }
    }
}
