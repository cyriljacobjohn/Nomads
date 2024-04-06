//
//  UserRegistrationViewModel.swift
//  UMI
//
//  Created by Sebastian Oberg on 4/4/24.
//

import Foundation

class UserRegistrationViewModel: ObservableObject {
    // Shared properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var uid: String = ""
    
    // Account type flag
    @Published var isStylist: Bool = false

    // Stylist specific properties
    @Published var clientsShouldKnow: String = ""
    @Published var specialities: [Int] = []
    @Published var avgPrice: Int = 0
    @Published var contacts: Contacts = Contacts()
    
    // Address
    @Published var address: Address = Address()

    // Method to handle signup
    func signUp(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/client/signup-client") else {
            completion(false)
            return
        }
        
        let signupData = ["email": email, "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: signupData)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                // Parse the JSON data and retrieve the UID if needed
                completion(true)
            } else {
                completion(false)
            }
        }

        task.resume()
    }


    // Client account creation method
    func createClientAccount(completion: @escaping (Bool) -> Void) {
        guard !uid.isEmpty else { return }

        let clientData: [String: Any] = [
            "fname": firstName,
            "lname": lastName,
            "uid": uid
            // Add other client-specific fields here
        ]
        // Perform client account creation request
        print("Client Data: \(clientData)")
        completion(true)
    }

    // Stylist account creation method
    func createStylistAccount(completion: @escaping (Bool) -> Void) {
        guard !uid.isEmpty else { return }

        let stylistData: [String: Any] = [
            "fname": firstName,
            "lname": lastName,
            "clients_should_know": clientsShouldKnow,
            "address": address.dictionary,
            "specialities": specialities,
            "avg_price": avgPrice,
            "uid": uid,
            "contacts": contacts.dictionary
        ]
        // Perform stylist account creation request
        print("Stylist Data: \(stylistData)")
        completion(true)
    }

    // Nested struct for address details
    struct Address {
        var street: String = ""
        var city: String = ""
        var state: String = ""
        var zipCode: String = ""
        var country: String = "USA"
        var comfortRadius: Int = 20

        var dictionary: [String: Any] {
            ["street": street, "city": city, "state": state, "zip_code": zipCode, "country": country, "comfort_radius": comfortRadius]
        }
    }

    // Nested struct for contact details
    struct Contacts {
        var phoneNum: String = ""
        var instagram: String = ""
        var twitter: String = ""
        var linkedTree: String = ""

        var dictionary: [String: Any] {
            ["phone_num": phoneNum, "instagram": instagram, "twitter": twitter, "linked_tree": linkedTree]
        }
    }
}
