//
//  GetRequestView.swift
//  UMI
//
//  Created by Sebastian Oberg on 3/31/24.
//

import SwiftUI

struct GetRequestView: View {
    var body: some View {
        Button("Fetch Stylists") {
            fetchStylists()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
    
    private func fetchStylists() {
        let urlString = "http://127.0.0.1:5000/stylist/mina/1"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching stylists: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("HTTP Error: Status code \(response.map { ($0 as? HTTPURLResponse)?.statusCode } ?? -1)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let stylistsData = try JSONDecoder().decode(StylistsResponse.self, from: data)
                for stylist in stylistsData.stylists {
                    print(stylist.fname)
                }
            } catch {
                print("JSON Decoding Error: \(error)")
            }
        }.resume()
    }
}

struct stylists: Codable {
    var distance: Double
    var fname: String
    var id: Int
    var latitude: Double
    var lname: String
    var longitude: Double
    var match_percentage: Double
    var rating: Double
    var specialities: [Int]
}

struct StylistsResponse: Codable {
    var stylists: [stylists]
}

struct GetRequestView_Previews: PreviewProvider {
    static var previews: some View {
        GetRequestView()
    }
}
