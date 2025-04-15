//
//  RestaurantCardsView.swift
//  RestaurantViewer
//
//  Created by Christine on 4/8/25.
//

import SwiftUI

struct RestaurantCardsView: View {
    @StateObject var restaurantViewModel = RestaurantViewModel(restaurantService: YelpAPI())
    @StateObject var locationManager = LocationManager() // to gain access to users location

 
    var body: some View {
        VStack {
            if let location = locationManager.location {
                ZStack {
                    ForEach(restaurantViewModel.currentIndex..<min(restaurantViewModel.currentIndex + 3, restaurantViewModel.restaurants.count), id: \.self) { index in
                        RestaurantCardView(restaurant: restaurantViewModel.restaurants[index], index: index)
                            .frame(width: 200, height: 300)
                            .offset(x: CGFloat(index - restaurantViewModel.currentIndex) * 20 + (index == restaurantViewModel.currentIndex && restaurantViewModel.animateCard ? restaurantViewModel.slideDirection : 0))
                            .scaleEffect(index == restaurantViewModel.currentIndex ? 1 : 0.95)
                            .zIndex(Double(restaurantViewModel.currentIndex - index))
                            .animation(.easeInOut, value: restaurantViewModel.currentIndex)
                    }
                }
                .onAppear {
                    restaurantViewModel.loadMoreRestaurants(lat: location.latitude, lon: location.longitude)
                }
                .onChange(of: restaurantViewModel.currentIndex) { _ in
                    if restaurantViewModel.currentIndex > restaurantViewModel.restaurants.count - 3 && !restaurantViewModel.isLoading {
                        restaurantViewModel.loadMoreRestaurants(lat: location.latitude, lon: location.longitude)
                    }
                }
            } else {
                Text("Getting your location...")
                    .padding()
            }
            
            HStack {
                Button(action: restaurantViewModel.showPrevious) {
                    Text("Previous")
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(restaurantViewModel.currentIndex == 0)
                
                Button(action: restaurantViewModel.showNext) {
                    Text("Next")
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(restaurantViewModel.currentIndex == restaurantViewModel.restaurants.count - 1)
            }
            .padding(.horizontal)
            
            if restaurantViewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
        }
    }

}

#Preview {
    RestaurantCardsView()
}
