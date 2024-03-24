//
//  AuthManager.swift
//  UMI
//
//  Created by Cyril John on 3/1/24.
//
import Foundation
import Supabase

struct AppUser {
    let uid: String
    let email: String?
}

class AuthManager{
    
    static let shared = AuthManager()
    
    private init() {}
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://sockukwcrqgwpkebbqfq.supabase.co")!, supabaseKey:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNvY2t1a3djcnFnd3BrZWJicWZxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDg1NjYzNDksImV4cCI6MjAyNDE0MjM0OX0.o-ZDDvAaeygbnK3JXy4vxQiQG7eaLN6L1Gum_MntsXo")
    
    func getCurrentSession() async throws -> AppUser {
        let session = try await client.auth.session
        print(session)
        print(session.user.id)
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
    // MARK: Registration
    func registerNewUserWithEmail(email: String, password: String) async throws -> AppUser {
        let regAuthResponse = try await client.auth.signUp(email: email, password: password)
        guard let session = regAuthResponse.session else {
            print("no session when registering user")
            throw NSError()
        }
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
    
    // MARK: Sign In
    func signInWithEmail(email: String, password: String) async throws -> AppUser {
        let session = try await client.auth.signIn(email: email, password: password)
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
        
    }
    
    func signInWithApple(idToken: String, nonce: String) async throws -> AppUser {
        let session = try await client.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: idToken, nonce: nonce))
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
    func signInWithGoogle(idToken: String, nonce: String) async throws -> AppUser {
//        try await network(idToken: idToken, nonce: nonce)
        let session = try await client.auth.signInWithIdToken(credentials: .init(provider: .google, idToken: idToken, nonce: nonce))
        print(session)
        print(session.user)
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
}


