//
//  UserSessionManager.swift
//  UMI
//
//  Created by Cyril John on 4/25/24.
//

import Foundation
import SwiftUI

class UserSessionManager: ObservableObject {
    static let shared = UserSessionManager()

    @Published var uid: String?  // Unique string identifier obtained during sign-up
    @Published var userId: Int?  // Integer user ID obtained when creating or signing in
    @Published var userType: String?

    private init() {}

    func printUserType() {
        if let userType = userType {
            print("Current User Type: \(userType)")
        } else {
            print("User type is not set.")
        }
    }
}

enum UserType {
    case client, stylist
}
