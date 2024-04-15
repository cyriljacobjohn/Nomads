//
//  StylistLandingPage.swift
//  UMI
//
//  Created by Cyril John on 4/1/24.
//

import SwiftUI

struct StylistLandingPage: View {
    @State private var showUMI = false
    @State private var fadeInAnimation = false

    private let typingSpeed: TimeInterval = 0.2 // seconds per character
    private let welcomeText = "Welcome to "
    private let umiText = "UMI"
    
    var body: some View {
        ZStack {
            Color("PrimaryColor").edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack(spacing: 0) {
                    TypingText(fullText: welcomeText, typingSpeed: typingSpeed)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBoldItalic", size: 20))
                    
                    if showUMI {
                        TypingText(fullText: umiText, typingSpeed: typingSpeed)
                            .foregroundColor(.white)
                            .font(.custom("Sarina-Regular", size: 30))
                            .transition(AnyTransition.opacity.animation(.easeIn(duration: 1.0)))
                    }
                }
                
                if fadeInAnimation {
                    Text("You're all set")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBoldItalic", size: 20))
                        .transition(AnyTransition.opacity.animation(.easeIn(duration: 5.0))) // Slow down the animation
                }
            }
        }
        .onAppear {
            startAnimations()
        }
        .onDisappear {
            // Reset the states when the view disappears to restart the animation next time it appears
            showUMI = false
            fadeInAnimation = false
        }
    }
    
    private func startAnimations() {
        DispatchQueue.main.asyncAfter(deadline: .now() + typingSpeed * Double(welcomeText.count)) {
            withAnimation {
                showUMI = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + typingSpeed * Double(welcomeText.count + umiText.count)) {
            withAnimation {
                fadeInAnimation = true
            }
        }
    }
}

struct TypingText: View {
    let fullText: String
    let typingSpeed: TimeInterval
    @State private var displayedText = ""

    var body: some View {
        Text(displayedText)
            .onAppear {
                displayedText = "" // Reset the text to start typing animation again
                typeText()
            }
    }

    private func typeText() {
        if displayedText.count < fullText.count {
            let index = fullText.index(fullText.startIndex, offsetBy: displayedText.count)
            displayedText.append(fullText[index])
            DispatchQueue.main.asyncAfter(deadline: .now() + typingSpeed) {
                typeText()
            }
        }
    }
}




