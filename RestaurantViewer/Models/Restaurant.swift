//
//  Restaurant.swift
//  RestaurantViewer
//
//  Created by Christine on 4/8/25.
//

import Foundation

struct YelpSearchResponse: Decodable {
    let businesses: [Restaurant]
}

struct Restaurant: Decodable, Identifiable {
    let id: String
    let name: String
    let image_url: String
    let rating: Double
}

struct MockData {
    static let sampleRestaurant = Restaurant(id: "0001", name: "Sushi", image_url: "https://arthrestaurant.com/wp-content/uploads/2024/11/IMG_6268-2-scaled.jpg", rating: 3)
    static let sampleRestaurantArr = [sampleRestaurant, sampleRestaurant, sampleRestaurant, sampleRestaurant, sampleRestaurant, sampleRestaurant, sampleRestaurant, sampleRestaurant, sampleRestaurant, sampleRestaurant, sampleRestaurant, sampleRestaurant, sampleRestaurant, sampleRestaurant, sampleRestaurant ]
}


