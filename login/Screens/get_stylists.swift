//
//  get_stylists.swift
//  UMI
//
//  Created by Cyril John on 4/7/24.
//


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
    var address: Address
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


struct Address: Decodable, Equatable {
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
    let avgPrice : Double
    
    enum CodingKeys: String, CodingKey {
        case id, fname, lname, city, state, street, specialities, distance, rating, avgPrice = "avg_price"
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


//struct ClientProfile: Decodable {
//    let fname: String
//    let lname: String
//    let ethnicity: [String]
//    let stylistsShouldKnow: String
//    let hairProfile: HairProfile
//    let address: Address
//    let interests: [String]
//
//    enum CodingKeys: String, CodingKey {
//        case fname, lname, ethnicity, interests, address
//        case stylistsShouldKnow = "stylists_should_know"
//        case hairProfile = "hair_profile"
//    }
//
//    struct HairProfile: Decodable {
//        let thickness: String
//        let hairType: String
//        let hairGender: String
//        let colorLevel: Int
//        let colorHist: String
//
//        enum CodingKeys: String, CodingKey {
//            case thickness
//            case hairType = "hair_type"
//            case hairGender = "hair_gender"
//            case colorLevel = "color_level"
//            case colorHist = "color_hist"
//        }
//    }
//
//    struct Address: Decodable {
//        let street: String
//        let city: String
//        let state: String
//        let zipCode: Int
//        let country: String
//        let comfortRadius: Double
//        let longitude: Double
//        let latitude: Double
//
//        enum CodingKeys: String, CodingKey {
//            case street, city, state, country, longitude, latitude
//            case zipCode = "zip_code"
//            case comfortRadius = "comfort_radius"
//        }
//    }
//}


struct ClientProfile: Decodable, Equatable {
    let fname: String
    let lname: String
    let ethnicity: [String]
    let stylistsShouldKnow: String
    let hairProfile: HairProfile
    var address: Address
    let interests: [String]
    
    enum CodingKeys: String, CodingKey {
        case fname, lname, ethnicity, interests, address
        case stylistsShouldKnow = "stylists_should_know"
        case hairProfile = "hair_profile"
    }
    
    // Equatable conformance for ClientProfile
    static func == (lhs: ClientProfile, rhs: ClientProfile) -> Bool {
        return lhs.fname == rhs.fname &&
               lhs.lname == rhs.lname &&
               lhs.ethnicity == rhs.ethnicity &&
               lhs.stylistsShouldKnow == rhs.stylistsShouldKnow &&
               lhs.hairProfile == rhs.hairProfile &&
               lhs.address == rhs.address &&
               lhs.interests == rhs.interests
    }

    struct HairProfile: Decodable, Equatable {
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
        
        // Equatable conformance for HairProfile
        static func == (lhs: HairProfile, rhs: HairProfile) -> Bool {
            return lhs.thickness == rhs.thickness &&
                   lhs.hairType == rhs.hairType &&
                   lhs.hairGender == rhs.hairGender &&
                   lhs.colorLevel == rhs.colorLevel &&
                   lhs.colorHist == rhs.colorHist
        }
    }
    
    struct Address: Decodable, Equatable {
        var street: String
        var city: String
        var state: String
        var zipCode: Int
        var country: String
        var comfortRadius: Double
        var longitude: Double
        var latitude: Double
        
        enum CodingKeys: String, CodingKey {
            case street, city, state, country, longitude, latitude
            case zipCode = "zip_code"
            case comfortRadius = "comfort_radius"
        }
        
        // Equatable conformance for Address
        static func == (lhs: Address, rhs: Address) -> Bool {
            return lhs.street == rhs.street &&
                   lhs.city == rhs.city &&
                   lhs.state == rhs.state &&
                   lhs.zipCode == rhs.zipCode &&
                   lhs.country == rhs.country &&
                   lhs.comfortRadius == rhs.comfortRadius &&
                   lhs.longitude == rhs.longitude &&
                   lhs.latitude == rhs.latitude
        }
    }
}



class ClientViewModel: ObservableObject {
    // Shared Properties
    
    var clientId: Int = 24
    @Published var stylists: [Stylist] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var favoriteStylists: [FavoriteStylist] = []
    @Published var client: ClientProfile?
    @Published var stylist: StylistProfile?
    
    //sort
    @Published var sortedStylists: [Stylist] = []
    
    // Ratings properties
    var averageRating: Double = 0
    
    //EDITT
    @Published var editableInterests: [String] = []
    
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
    
    
    //______________________FETCH STYLISTS_____________________________________________________
    
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
    
    func mapInterestsToIDs(interests: [String]) -> [Int] {
        let hair_tags = [
            "fine hair": 1,
            "medium hair": 2,
            "coarse hair": 3,
            "straight hair": 4,
            "wavy hair": 5,
            "curly hair": 6,
            "feminine": 7,
            "masculine": 8,
            "androgynous": 9,
            "2A": 10,
            "2B": 11,
            "2C": 12,
            "3A": 13,
            "3B": 14,
            "3C": 15,
            "4A": 16,
            "4B": 17,
            "4C": 18,
            "fades": 19,
            "long haircuts": 20,
            "color services": 21,
            "braids": 22,
            "alt cuts": 23
        ]
        var ids = [Int]()
        for interest in interests {
            if let id = hair_tags[interest] {
                ids.append(id)
            } else {
                print("Warning: No mapping found for \(interest)")
            }
        }
        return ids
    }
    
    //________________SORT STYLISTS_________________________________________________
    
    func sortStylists(by option: SortOption) {
        switch option {
        case .matchPercentage:
            sortedStylists = stylists.sorted { $0.matchPercentage > $1.matchPercentage }
        case .distance:
            sortedStylists = stylists.sorted { $0.distance < $1.distance }
        case .rating:
            sortedStylists = stylists.sorted { ($0.rating ?? 0.0) > ($1.rating ?? 0.0) }
        case .avgPrice:
            sortedStylists = stylists.sorted { $0.avgPrice < $1.avgPrice }
        }
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
                print(String(data: data, encoding: .utf8) ?? "Invalid JSON data")
                
                let decodedResponse = try JSONDecoder().decode(StylistProfile.self, from: data)
                DispatchQueue.main.async {
                    print("Fetched stylist profile successfully")
                    completion(.success(decodedResponse)) // Using Result with Success
                }
            } catch let DecodingError.dataCorrupted(context) {
                print("Data corrupted: \(context)")
                DispatchQueue.main.async {
                    self.errorMessage = "Data corrupted: \(context.debugDescription)"
                    completion(.failure(DecodingError.dataCorrupted(context)))
                }
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found: \(context.debugDescription), codingPath: \(context.codingPath)")
                DispatchQueue.main.async {
                    self.errorMessage = "Key '\(key)' not found: \(context.debugDescription)"
                    completion(.failure(DecodingError.keyNotFound(key, context)))
                }
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found: \(context.debugDescription), codingPath: \(context.codingPath)")
                DispatchQueue.main.async {
                    self.errorMessage = "Value '\(value)' not found: \(context.debugDescription)"
                    completion(.failure(DecodingError.valueNotFound(value, context)))
                }
            } catch let DecodingError.typeMismatch(type, context) {
                print("Type '\(type)' mismatch: \(context.debugDescription), codingPath: \(context.codingPath)")
                DispatchQueue.main.async {
                    self.errorMessage = "Type '\(type)' mismatch: \(context.debugDescription)"
                    completion(.failure(DecodingError.typeMismatch(type, context)))
                }
            } catch {
                print("Unexpected error: \(error).")
                DispatchQueue.main.async {
                    self.errorMessage = "Unexpected error: \(error.localizedDescription)"
                    completion(.failure(error))
                }
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
    
    //___________________________UPDATE PROFILE_________________________________________
    
    func updateClientAddress(clientId: Int, address: ClientProfile.Address, completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/client/update-address/\(clientId)") else {
            completion(false, "Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "street": address.street,
            "city": address.city,
            "state": address.state,
            "zip_code": address.zipCode,
            "country": address.country,
            "comfort_radius": address.comfortRadius
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
        } catch {
            completion(false, "JSON serialization failed: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(false, "No response received")
                return
            }
            let statusCode = httpResponse.statusCode
            var responseMessage = "Unknown error occurred"
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                responseMessage = responseString
                print("Response: \(responseString)")
            }
            
            switch statusCode {
            case 200:
                completion(true, "Address updated successfully")
            case 400:
                completion(false, "Bad request: \(responseMessage)")
            case 404:
                completion(false, "Not found: \(responseMessage)")
            case 500:
                completion(false, "Internal server error: \(responseMessage)")
            default:
                completion(false, "HTTP \(statusCode): \(responseMessage)")
            }
        }.resume()
    }

    
    //___________________STYLISTS SHOULD KNOW_______________________
    
    func updateStylistsShouldKnow(clientId: Int, text: String, completion: @escaping (Bool, String) -> Void) {
            guard let url = URL(string: "http://127.0.0.1:5000/client/update-stylists-should-know/\(clientId)") else {
                completion(false, "Invalid URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body: [String: Any] = [
                "stylists_should_know": text
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body)
            } catch {
                completion(false, "JSON Serialization failed")
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completion(false, "Failed to update Stlists should know")
                    return
                }
                completion(true, "stylistsShouldKnow updated successfully")
            }.resume()
        }
    
    
    //______________________INTERESTS___________________________
    
    func updateClientInterests(clientId: Int, interests: [String], completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/client/update-interests/\(clientId)") else {
            completion(false, "Invalid URL")
            return
        }

        let interestIDs = mapInterestsToIDs(interests: interests)
        print("Updating interests for client ID: \(clientId) with interests IDs: \(interestIDs)")

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["interests": interestIDs]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            print("Request body formed successfully")
        } catch {
            print("JSON Serialization failed: \(error.localizedDescription)")
            completion(false, "JSON Serialization failed")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(false, "Network error: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, let responseData = data else {
                print("No valid HTTP URL response or data received")
                completion(false, "Invalid response from the server")
                return
            }

            let responseString = String(data: responseData, encoding: .utf8) ?? "No response body"
            print("Response Status Code: \(httpResponse.statusCode)")
            print("Response Body: \(responseString)")
            
            switch httpResponse.statusCode {
            case 200:
                completion(true, "Interests updated successfully")
            case 400, 404:
                print("Error response from server: \(responseString)")
                completion(false, "Server reported error: \(responseString)")
            default:
                print("Unexpected server error with status code: \(httpResponse.statusCode) and response: \(responseString)")
                completion(false, "Unexpected server error with status code: \(httpResponse.statusCode) and response: \(responseString)")
            }
        }.resume()
    }


    
    func updateComfortRadius(clientId: Int, comfortRadius: Double, completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/client/change-radius/\(clientId)") else {
            completion(false, "Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["comfort_radius": comfortRadius]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            completion(false, "JSON Serialization failed")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let errorMessage = String(data: data ?? Data(), encoding: .utf8) ?? "Unknown error"
                completion(false, "Failed to update comfort radius: \(errorMessage)")
                return
            }
            completion(true, "Comfort radius updated successfully")
        }.resume()
    }
    
    
    func updateStylistAddress(stylistId: Int, address: Address, completion: @escaping (Bool, String) -> Void) {
            let url = URL(string: "https://your.api.endpoint/update-address/\(stylistId)")!
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let addressData = [
                "street": address.street,
                "city": address.city,
                "state": address.state,
                "zipCode": address.zipCode,
                "country": address.country,
                "comfortRadius": address.comfortRadius
            ] as [String : Any]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: addressData, options: [])
            } catch {
                completion(false, "Failed to encode address data")
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(false, "Network error: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        completion(false, "Server error")
                        return
                    }
                    
                    completion(true, "Address updated successfully")
                }
            }.resume()
        }


}
