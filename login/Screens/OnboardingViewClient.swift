//
//  OnboardingViewClient.swift
//  UMI
//
//  Created by Cyril John on 4/6/24.
//

import Foundation
import SwiftUI


struct OnboardingViewClient : View {
    
    @Binding var showOnboarding: Bool
    @State private var selection: Int = 0
    
    
    func navigateToNextPage() {
        if selection < 4 { // Ensures the selection does not exceed 6
            selection += 1
        } else {
            // Here, you might set showOnboarding to false or perform any other action needed when onboarding is completed
            withAnimation{
                showOnboarding = false
            }
        }
    }
    
    var body: some View{
        TabView(selection: $selection){
            
            NameEntryScreenView(continueAction: navigateToNextPage)
                .tag(0)
            AccountTypeSelectionView(continueAction: navigateToNextPage)
                .tag(1)
            HairGenderSelectionScreenView(continueAction: navigateToNextPage)
                .tag(2)
            HairIDScreenView(continueAction: navigateToNextPage)
                .tag(3)
            PreferenceScreenView(continueAction: navigateToNextPage)
                .tag(4)
            
        }
        
    }
}

//struct OnboardingViewClient_Previews: PreviewProvider{
//    static var previes: some View{
//        OnboardingViewClient(showOnboarding: .constant(true))
//    }
//}
