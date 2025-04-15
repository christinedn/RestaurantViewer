//
//  YelpAPI.swift
//  RestaurantViewer
//
//  Created by Christine on 4/8/25.
//

import Foundation

protocol RestaurantAPIProtocol {
    func fetchRestaurants(lat: Double, lon: Double, limit: Int, offset: Int, completion: @escaping ([Restaurant]) -> Void)
}

class YelpAPI : RestaurantAPIProtocol {
    static let apiKey = "itoMaM6DJBtqD54BHSZQY9WdWR5xI_CnpZdxa3SG5i7N0M37VK1HklDDF4ifYh8SI-P2kI_mRj5KRSF4_FhTUAkEw322L8L8RY6bF1UB8jFx3TOR0-wW6Tk0KftNXXYx"

    func fetchRestaurants(lat: Double, lon: Double, limit: Int, offset: Int, completion: @escaping ([Restaurant]) -> Void) {
        let urlString = "https://api.yelp.com/v3/businesses/search?term=restaurants&latitude=\(lat)&longitude=\(lon)&limit=\(limit)&offset=\(offset)"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        
        request.setValue("Bearer \(YelpAPI.apiKey)", forHTTPHeaderField: "Authorization")

        // make HTTP request
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(YelpSearchResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(result.businesses)
                }
            } catch {
                print("Error decoding:", error)
            }
        }.resume()
    }
}

