//
//  get_stylists.swift
//  UMI
//
//  Created by Cyril John on 4/7/24.
//


import Foundation
import SwiftUI
//stylist properties'

struct StylistResponse: Decodable {
    let stylists: [Stylist]
}

struct Stylist: Decodable, Identifiable {
    let id: Int
    let fname: String
    let lname: String
    let city: String
    let state: String
    let street: String
    let zipCode: Int
    let distance: Double
    let matchPercentage: Double
    let rating: Double?
    let specialities: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, fname, lname, city, state, street, specialities, distance, rating
        case matchPercentage = "match_percentage"
        case zipCode = "zip_code"
    }
}

class ClientViewModel: ObservableObject {
    // Shared Properties
    
    var clientId: Int = 1
    @Published var stylists: [Stylist] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // Function to fetch stylists with a completion handler to notify of the request's success or failure
    
    func fetchStylists(completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        guard let url = URL(string: "http://127.0.0.1:5000/stylist/mina/\(clientId)") else {
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMessage = "Invalid URL"
                print("Invalid URL")
                completion(false) // Call completion with false due to invalid URL
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network request failed: \(error.localizedDescription)"
                }
                print("Network request failed: \(error.localizedDescription)")
                completion(false) // Call completion with false due to network request failure
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "Server error or no data"
                }
                print("Server error or no data")
                completion(false) // Call completion with false due to server error or no data
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(StylistResponse.self, from: data)
                DispatchQueue.main.async {
                    self.stylists = decodedResponse.stylists
                    print("Fetched stylists successfully")
                    completion(true) // Call completion with true upon successful fetch
                }
            } catch let DecodingError.dataCorrupted(context) {
                print("Data corrupted: \(context.debugDescription)")
                DispatchQueue.main.async {
                    self.errorMessage = "Data corrupted: \(context.debugDescription)"
                }
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found: \(context.debugDescription)")
                DispatchQueue.main.async {
                    self.errorMessage = "Key '\(key)' not found: \(context.debugDescription)"
                }
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found: \(context.debugDescription)")
                DispatchQueue.main.async {
                    self.errorMessage = "Value '\(value)' not found: \(context.debugDescription)"
                }
            } catch let DecodingError.typeMismatch(type, context) {
                print("Type '\(type)' mismatch: \(context.debugDescription)")
                DispatchQueue.main.async {
                    self.errorMessage = "Type '\(type)' mismatch: \(context.debugDescription)"
                }
            } catch {
                print("Unexpected error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.errorMessage = "Unexpected error: \(error.localizedDescription)"
                }
            }
            completion(false) // Call completion with false due to error
        }
        
        task.resume()
    }
    
    // ________________________ ADD TO FAVORITES ___________________________________
    func addToFavorites(stylistId: Int, completion: @escaping (Bool) -> Void) {
        let urlString = "http://127.0.0.1:5000/add-to-favourites/\(clientId)"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL"
            }
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Int] = ["stylist_id": stylistId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network request failed: \(error.localizedDescription)"
                }
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                DispatchQueue.main.async {
                    self.errorMessage = "Server error or no data"
                }
                completion(false)
                return
            }

            DispatchQueue.main.async {
                print("Stylist added to favorites successfully")
                completion(true)
            }
        }

        task.resume()
    }

    
    //_______________REMOVE FROM FAVORITES______________________
    
    func removeFromFavorites(stylistId: Int, completion: @escaping (Bool) -> Void) {
        let urlString = "http://127.0.0.1:5000/remove-from-favourites/\(clientId)"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL"
            }
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Int] = ["stylist_id": stylistId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network request failed: \(error.localizedDescription)"
                }
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.errorMessage = "Server error or no data"
                }
                completion(false)
                return
            }

            DispatchQueue.main.async {
                print("Stylist removed from favorites successfully")
                completion(true)
            }
        }

        task.resume()
    }

    
    
    
}


    
    


