////
////  OnboardingViewClient.swift
////  UMI
////
////  Created by Cyril John on 4/6/24.
////
//
//import Foundation
//import SwiftUI
//
//
//import SwiftUI
//
//struct OnboardingViewClient: View {
//    @Binding var showOnboarding: Bool
//    @State private var currentStep: OnboardingStep = .welcome
//
//    var body: some View {
//        switch currentStep {
//        case .welcome:
//            WelcomeScreenView(
//                signUpAction: { currentStep = .signUp },
//                signInAction: { currentStep = .signIn }
//            )
//        case .signUp:
//            SignUpScreenView(onCompleted: {
//                showOnboarding = false
//            })
//        case .signIn:
//            SignInScreenView(onCompleted: {
//                showOnboarding = false
//            })
//        }
//    }
//}
//
//enum OnboardingStep {
//    case welcome, signUp, signIn
//}
//
//
////struct OnboardingViewClient_Previews: PreviewProvider{
////    static var previes: some View{
////        OnboardingViewClient(showOnboarding: .constant(true))
////    }
////}
