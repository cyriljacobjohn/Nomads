//
//  SupabaseAuthApp.swift
//  UMI
//
//  Created by Cyril John on 3/18/24.
//

import SwiftUI
import GoogleSignIn
struct SupabaseAuthApp: App{
    var body: some Scene{
        WindowGroup{
            ContentView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
