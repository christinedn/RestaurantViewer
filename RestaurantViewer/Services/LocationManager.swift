//
//  LocationManager.swift
//  RestaurantViewer
//
//  Created by Christine on 4/8/25.
//

import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self // sets current class to handle delegate callbacks
        manager.requestWhenInUseAuthorization() // prompts user for location access
        manager.startUpdatingLocation() // to fetch location updates 
    }

    // delegate method that is triggered when a new location update is received
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.first?.coordinate {
            location = loc
            manager.stopUpdatingLocation()
        }
    }
}
