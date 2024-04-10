//
//  TabView.swift
//  UMI
//
//  Created by Cyril John on 4/6/24.
//

// Tabs for a client


import SwiftUI

struct MainTabView: View {
    private let favoriteStylistUUIDs: [UUID] = [UUID(), UUID()]
    
    init() {
            // Customize the tab bar appearance using UITabBarAppearance
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor.black // Set your desired background color

            // Use this appearance when the tab bar is scrolled behind content
            UITabBar.appearance().standardAppearance = appearance

            // Use this appearance when the tab bar is not scrolled behind content
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    
    var body: some View {
        TabView {
            DiscoveryPageView(viewModel: ClientViewModel())
                .tabItem {
                    Image("umi-logo")
                        
                }

            //FavoritesPageView(favoriteStylistUUIDs: favoriteStylistUUIDs)
                .tabItem {
                    Image("favorite")
                       
                }

           // ClientProfileView(clientId: UUID())
                .tabItem {
                    Image("about-me")
                        
                }
        }
    }
}



