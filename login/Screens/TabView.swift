//
//  TabView.swift
//  UMI
//
//  Created by Cyril John on 4/5/24.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            ForYouScreenView().tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }.tag(1)
            ProfileView().tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }.tag(2)
            SettingsView().tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }.tag(3)
        }
    }
}
