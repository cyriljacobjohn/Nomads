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

struct StylistProfile: Decodable, Equatable {
    let address: Address
    let avgPrice: Double
    let clientsShouldKnow: String
    let fname: String
    let lname: String
    let rating: Double?
    let specialities: [String]

    enum CodingKeys: String, CodingKey {
        case fname, lname, address, specialities, rating
        case avgPrice = "avg_price"
        case clientsShouldKnow = "clients_should_know"
    }

    static func == (lhs: StylistProfile, rhs: StylistProfile) -> Bool {
        lhs.fname == rhs.fname &&
        lhs.lname == rhs.lname &&
        lhs.address == rhs.address &&
        lhs.avgPrice == rhs.avgPrice &&
        lhs.clientsShouldKnow == rhs.clientsShouldKnow &&
        lhs.rating == rhs.rating &&
        lhs.specialities == rhs.specialities
    }
}


struct Address: Decodable, Equatable{
    let city: String
    let comfortRadius: Int
    let country: String
    let latitude: Double
    let longitude: Double
    let state: String
    let street: String
    let zipCode: Int
    
    enum CodingKeys: String, CodingKey {
        case city, country, latitude, longitude, state, street
        case comfortRadius = "comfort_radius"
        case zipCode = "zip_code"
    }
    
    var formattedAddress: String {
            return "\(street), \(city), \(state) \(zipCode), \(country)"
        }
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


struct FavoriteStylists: Decodable {
    let ayoStatus: String
    let stylists: [FavoriteStylist]
    
    enum CodingKeys: String, CodingKey {
        case ayoStatus = "ayo_status"
        case stylists
    }
}

struct FavoriteStylist: Decodable {
    let id: Int
    let fname: String
    let lname: String
    let avgPrice: Double
    let rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, fname, lname, rating
        case avgPrice = "avg_price"
    }
}
// RATINGS

struct Rating: Codable, Identifiable {
    var rating_id: Int
    var client_id: Int
    var client_name: String
    var review: String
    var stars: Double
    var tags: [String]
    
    var id: Int { rating_id }
}

struct RatingsResponse: Decodable {
    var average_rating: Double
    var ayo_status: String
    var ratings: [Rating]
    var stylist_id: Int
}


// CLIENT Profile


struct ClientProfile: Decodable {
    let fname: String
    let lname: String
    let ethnicity: [String]
    let stylistsShouldKnow: String
    let hairProfile: HairProfile
    let address: Address
    let interests: [String]
    
    enum CodingKeys: String, CodingKey {
        case fname, lname, ethnicity, interests, address
        case stylistsShouldKnow = "stylists_should_know"
        case hairProfile = "hair_profile"
    }
    
    struct HairProfile: Decodable {
        let thickness: String
        let hairType: String
        let hairGender: String
        let colorLevel: Int
        let colorHist: String
        
        enum CodingKeys: String, CodingKey {
            case thickness
            case hairType = "hair_type"
            case hairGender = "hair_gender"
            case colorLevel = "color_level"
            case colorHist = "color_hist"
        }
    }
    
    struct Address: Decodable {
        let street: String
        let city: String
        let state: String
        let zipCode: Int
        let country: String
        let comfortRadius: Double
        let longitude: Double
        let latitude: Double
        
        enum CodingKeys: String, CodingKey {
            case street, city, state, country, longitude, latitude
            case zipCode = "zip_code"
            case comfortRadius = "comfort_radius"
        }
    }
}



class ClientViewModel: ObservableObject {
    // Shared Properties
    
    var clientId: Int = 1
    @Published var stylists: [Stylist] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var favoriteStylists: [FavoriteStylist] = []
    @Published var client: ClientProfile?
    @Published var stylist: StylistProfile?
    
    // Ratings properties
    
    
    var averageRating: Double = 0
    
    @Published var ratings: [Rating] = []
    @Published var tags: [String] = []
    
    func updateTags() {
        var allTags: Set<String> = []
        for rating in ratings {
            allTags.formUnion(rating.tags)
        }
        DispatchQueue.main.async {
            self.tags = Array(allTags)
        }
    }
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
    
    //________________________FETCH STYLIST PROFILE_________________________________
    
    
    func fetchStylistProfileById(stylistId: Int, completion: @escaping (Result<StylistProfile, Error>) -> Void) {
        print("Fetching stylist profile for ID: \(stylistId)")
        self.isLoading = true
        guard let url = URL(string: "http://127.0.0.1:5000/stylist/read-stylist/\(stylistId)") else {
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMessage = "Invalid URL"
                print("Invalid URL for stylist ID: \(stylistId)") // Enhanced debug print
                completion(.failure(URLError(.badURL))) // Corrected to use Result with Error
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
                completion(.failure(error)) // Corrected to use Result with Error
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "Server error or no data"
                }
                print("Server error or no data")
                completion(.failure(URLError(.badServerResponse))) // Corrected to use Result with Error
                return
            }
            
            do {
                print("Received JSON data:")
                print(String(data: data, encoding: .utf8) ?? "")
                
                let decodedResponse = try JSONDecoder().decode(StylistProfile.self, from: data)
                DispatchQueue.main.async {
                    print("Fetched stylist profile successfully")
                    completion(.success(decodedResponse)) // Using Result with Success
                }
            } catch {
                print("Failed to decode stylist profile: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode stylist profile: \(error.localizedDescription)"
                }
                completion(.failure(error)) // This is now correctly passing an Error
            }
            
        }
        
        task.resume()
    }
    
    
    
    // ________________________ ADD TO FAVORITES ___________________________________
    func addToFavorites(stylistId: Int, completion: @escaping (Bool) -> Void) {
        let urlString = "http://127.0.0.1:5000/client/add-to-favourites/\(clientId)"
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL"
                print("Error: Invalid URL - \(urlString)")
                completion(false)
            }
            return
        }
        
        print("Client ID: \(clientId)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Int] = ["stylist_id": stylistId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        print("Request URL: \(request.url?.absoluteString ?? "")")
        print("Request Body: \(String(data: request.httpBody ?? Data(), encoding: .utf8) ?? "")")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network request failed: \(error.localizedDescription)"
                    print("Network request failed: \(error.localizedDescription)")
                    completion(false)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid response"
                    print("Invalid response")
                    completion(false)
                }
                return
            }
            
            print("Response Status Code: \(httpResponse.statusCode)")
            
            guard httpResponse.statusCode == 201 else {
                DispatchQueue.main.async {
                    self.errorMessage = "Server error or unexpected response"
                    print("Server error or unexpected response")
                    completion(false)
                }
                return
            }
            
            DispatchQueue.main.async {
                print("Stylist added to favorites successfully")
                completion(true)
            }
        }
        
        task.resume()
    }
    
    // _______________REMOVE FROM FAVORITES______________________
    func removeFromFavorites(stylistId: Int, completion: @escaping (Bool) -> Void) {
        let urlString = "http://127.0.0.1:5000/client/remove-from-favourites/\(clientId)"
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL"
                print("Error: Invalid URL - \(urlString)")
                completion(false)
            }
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
                    completion(false)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.errorMessage = "Server error or no data"
                    completion(false)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(true)
            }
        }.resume()
    }
    
    
    //_____________GET FAVORITE STYLISTS_____________________
    
    
    func getFavoriteStylists(completion: @escaping (Bool) -> Void) {
        let urlString = "http://127.0.0.1:5000/client/get-all-favs/\(clientId)"
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL"
                completion(false)
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network request failed: \(error.localizedDescription)"
                    completion(false)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.errorMessage = "Server error or no data"
                    completion(false)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                    completion(false)
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(FavoriteStylists.self, from: data)
                if response.ayoStatus == "success" {
                    DispatchQueue.main.async {
                        self.favoriteStylists = response.stylists
                        completion(true)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to get favorite stylists"
                        completion(false)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode response"
                    completion(false)
                }
            }
        }.resume()
    }
    
    func isStylistFavorite(stylistId: Int) -> Bool {
        return favoriteStylists.contains(where: { $0.id == stylistId })
    }
    
    
    //_____________________VIEW REVIEWS_________________________________
    
    
    func getStylistRatings(stylistId: Int, completion: @escaping (Bool) -> Void) {
        let urlString = "http://127.0.0.1:5000/stylist/get-ratings/\(stylistId)"
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL"
                completion(false)
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network request failed: \(error.localizedDescription)"
                    completion(false)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.errorMessage = "Server error or no data"
                    completion(false)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                    completion(false)
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(RatingsResponse.self, from: data)
                if response.ayo_status == "success" {
                    DispatchQueue.main.async {
                        self.ratings = response.ratings
                        self.averageRating = response.average_rating
                        completion(true)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to get stylist ratings"
                        completion(false)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode response"
                    completion(false)
                }
            }
        }.resume()
    }
    
    func updateTagsFromRatings() {
        var allTags = Set<String>()
        for rating in ratings {
            allTags.formUnion(Set(rating.tags))
        }
        self.tags = Array(allTags).sorted() // Convert set to array and sort if necessary
    }
    
    //________________CREATE RATING_______________________
    
    
    func postReview(clientId: Int, stylistId: Int, rating: Int, comment: String, completion: @escaping (Bool, String) -> Void) {
            // URL and request setup
            guard let url = URL(string: "http://127.0.0.1:5000/client/create-rating") else {
                completion(false, "Invalid URL")
                return
            }
            
            let reviewData = [
                "client_id": clientId,
                "stylist_id": stylistId,
                "review": comment,
                "stars": rating
            ] as [String : Any]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: reviewData)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        completion(false, "Network or server error")
                    }
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let status = json["ayo_status"] as? String, status == "success" {
                            DispatchQueue.main.async {
                                completion(true, "Rating successfully made!")
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(false, "Failed to create rating")
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(false, "Error parsing response")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false, "Server error")
                    }
                }
            }
            
            task.resume()
        }
    
    
    //__________________CLIENT PROFILE_________________________
    
    func fetchClientProfile(clientId: Int) {
        print("Fetching client profile for clientId: \(clientId)")
        
        self.isLoading = true
        let urlString = "http://127.0.0.1:5000/client/read-client/\(clientId)"
        print("URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMessage = "Invalid URL"
            }
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            print("Received response")
            
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    print("Network request failed: \(error.localizedDescription)")
                    self?.errorMessage = "Network request failed: \(error.localizedDescription)"
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    self?.errorMessage = "Invalid response"
                    return
                }
                
                print("Response status code: \(httpResponse.statusCode)")
                
                guard httpResponse.statusCode == 200 else {
                    print("Server error or unexpected status code")
                    self?.errorMessage = "Server error or unexpected status code"
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    self?.errorMessage = "No data received"
                    return
                }

                do {
                    print("Decoding response")
                    let decodedResponse = try JSONDecoder().decode(ClientProfile.self, from: data)
                    print("Decoded client profile: \(decodedResponse)")
                    self?.client = decodedResponse
                } catch {
                    print("Failed to decode the client profile: \(error.localizedDescription)")
                    self?.errorMessage = "Failed to decode the client profile: \(error.localizedDescription)"
                }
            }
        }.resume()
    }

}


    
    


