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
    
    // Client specific properties
    @Published var ethnicity: [String] = []
    @Published var stylistsShouldKnow: String = ""
    @Published var hairProfile: HairProfile = HairProfile()
    @Published var interests: [Int] = []
    
    // Account type flag
    @Published var isStylist: Bool = false

    // Stylist specific properties
    @Published var specialties: [Int] = []
    @Published var avgPrice: Int = 0
    @Published var contacts: Contacts = Contacts()
    @Published var phoneNum: String = ""
    
    // Address
    @Published var address: Address = Address()

    func signUp(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/client/signup-user") else {
            completion(false)
            return
        }
        
        let signupData = ["email": email, "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: signupData)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let uid = json["user_uid"] as? String {
                        DispatchQueue.main.async {
                            self.uid = uid
                            print("Success: UID - \(uid)")
                        }
                        completion(true)
                    } else {
                        print("Failed to parse UID from response")
                        completion(false)
                    }
                } catch {
                    print("Error parsing response: \(error.localizedDescription)")
                    completion(false)
                }
            } else {
                print("Server returned status code other than 200")
                completion(false)
            }
        }

        task.resume()
    }

    func createClientAccount(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/client/create-client"), !uid.isEmpty else {
            DispatchQueue.main.async {
                completion(false)
            }
            return
        }
        
        let clientData = getClientData()
        print("Client Data: \(clientData)")

        guard let jsonData = try? JSONSerialization.data(withJSONObject: clientData) else {
            DispatchQueue.main.async {
                completion(false)
            }
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error during URLSessionDataTask: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response from server.")
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }

            switch httpResponse.statusCode {
            case 200...299:
                // Success response.
                DispatchQueue.main.async {
                    completion(true)
                }
            default:
                // Server returned an error. Use data to get more information if needed.
                print("Server error with status code: \(httpResponse.statusCode)")
                if let data = data, let string = String(data: data, encoding: .utf8) {
                    print("Server response: \(string)")
                }
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }

        task.resume()
    }


    
    func getClientData() -> [String: Any] {
        [
            "fname": firstName,
            "lname": lastName,
            "address": address.dictionary,
            "ethnicity": ethnicity,
            "stylists_should_know": stylistsShouldKnow,
            "hair_profile": hairProfile.dictionary,
            "interests": interests,
            "uid": uid
        ]
    }

    func createStylistAccount(completion: @escaping (Bool) -> Void) {
        let urlString = "http://127.0.0.1:5000/stylist/create-stylist"
        guard let url = URL(string: urlString), !uid.isEmpty else {
            completion(false)
            return
        }

        let stylistData: [String: Any] = [
            "fname": firstName,
            "lname": lastName,
            "clients_should_know": stylistsShouldKnow,
            "address": address.dictionary,
            "specialities": specialties,  // Changed from "specialties" to "specialities" to match the backend since Ayo can't spell
            "avg_price": avgPrice,
            "uid": uid,
            "contacts": contacts.dictionary
        ]


        guard let jsonData = try? JSONSerialization.data(withJSONObject: stylistData) else {
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error during URLSessionDataTask: \(error.localizedDescription)")
                completion(false)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response from server.")
                completion(false)
                return
            }

            if 200...299 ~= httpResponse.statusCode {
                completion(true)
            } else {
                print("Server error with status code: \(httpResponse.statusCode)")
                completion(false)
            }
        }

        task.resume()
    }
    
    func signIn(completion: @escaping (Bool, String, String) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/client/signin-user") else {
            completion(false, "", "")
            return
        }

        let signInData = ["email": email, "password": password]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: signInData) else {
            completion(false, "", "")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                completion(false, "", "")
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let ayoStatus = json["ayo_status"] as? String,
                       let userType = json["user_type"] as? String {
                        DispatchQueue.main.async {
                            completion(true, ayoStatus, userType)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(false, "", "")
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(false, "", "")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(false, "", "")
                }
            }
        }

        task.resume()
    }

    struct Address {
        var street: String = ""
        var city: String = ""
        var state: String = ""
        var zipCode: String = ""
        var country: String = ""
        var comfortRadius: Int = 20

        var dictionary: [String: Any] {
            ["street": street, "city": city, "state": state, "zip_code": zipCode, "country": country, "comfort_radius": comfortRadius]
        }
    }

    struct HairProfile {
        var thickness: Int = 0 // Use 0 as default to indicate no selection
        var hairType: Int = 0 // Use 0 as default to indicate no selection
        var hairGender: Int = 1
        var colorHist: String = ""
        var colorLevel: Int = 3

        var dictionary: [String: Any] {
            ["thickness": thickness, "hair_type": hairType, "hair_gender": hairGender, "color_hist": colorHist, "color_level": colorLevel]
        }

        func isValid() -> Bool {
            return thickness != 0 && hairType != 0 && !colorHist.isEmpty
        }
    }

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
