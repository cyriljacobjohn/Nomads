//
//  TabViewStylist.swift
//  UMI
//
//  Created by Cyril John on 4/6/24.
//

import SwiftUI

struct StylistTabView: View {
    
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
            StylistLandingPage()
                .tabItem {
                    Image("umi-logo")
                }
            
            MyReviewsView(stylistId: 1)
                .tabItem {
                    Image(systemName: "star.fill")
                                .foregroundColor(.white)
                }
            
            StylistProfileView(stylistId: 1)
                .tabItem {
                    Image("about-me")
                        
                }
            
        }
        .accentColor(.primary)
    }
}

