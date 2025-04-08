//
//  RestaurantViewModel.swift
//  RestaurantViewer
//
//  Created by Christine on 4/8/25.
//

import Foundation
import SwiftUI

class RestaurantViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var currentIndex = 0
    @Published var animateCard = false
    @Published var slideDirection: CGFloat = -300
    @Published var isLoading = false
    @Published var offset = 0
    @Published var limit = 5
    let restaurantService: RestaurantAPIProtocol
    init(restaurantService: RestaurantAPIProtocol) {
        self.restaurantService = restaurantService
    }
    
     func loadMoreRestaurants(lat: Double, lon: Double) {
        isLoading = true
        offset += limit
        restaurantService.fetchRestaurants(lat: lat, lon: lon, limit: limit, offset: offset) { data in
            self.restaurants.append(contentsOf: data)
            self.isLoading = false
        }
    }
    
    func showNext() {
        if currentIndex < restaurants.count - 1 {
            slideDirection = -300
            withAnimation(.easeInOut(duration: 0.3)) {
                self.animateCard = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.animateCard = false
                self.currentIndex += 1
            }
        }
    }
    
    func showPrevious() {
        if currentIndex > 0 {
            slideDirection = 300
            withAnimation(.easeInOut(duration: 0.3)) {
                self.animateCard = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.animateCard = false
                self.currentIndex -= 1
            }
        }
    }
}


