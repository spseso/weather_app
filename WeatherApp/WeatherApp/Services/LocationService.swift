//
//  LocationService.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation
import CoreLocation

// LocationServiceDelegate protocol for reporting the current location
protocol LocationServiceDelegate: AnyObject {
    func currentLocationFound(latitude: Double, longitude: Double)
    func currentCityFound(city: City)
    func cityNotFoundForLocation(latitude: Double, longitude: Double)
}

// LocationService to handle location related operations
final class LocationService: NSObject {
    // Location manager to request and receive location updates
    private let locationManager = CLLocationManager()
    
    // Delegate to report the location
    weak var delegate: LocationServiceDelegate?

    // Initialize the location manager and request authorization
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Start updating the user location
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    // Called when location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Get the last updated location
        guard let location = locations.last else { return }
        // Stop updating the location
        locationManager.stopUpdatingLocation()
        // Report the current location to the delegate
        delegate?.currentLocationFound(latitude: location.coordinate.latitude, longitude: location.coordinate.latitude)
        // Reverse geocode the location to get the city name
        CLGeocoder().reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en-US")) { (placemarks, error) in
            // Check if placemarks exist and get the first placemark
            if let places = placemarks,
               let place = places.first,
               let location = place.location,
               let name = place.locality {
                // Create a City object with the found location and assign it to foundCity property
                self.delegate?.currentCityFound(city: City(name: name, longitude: location.coordinate.longitude, latitude: location.coordinate.latitude))
            } else {
                // Report that current location name not found to the delegate
                self.delegate?.cityNotFoundForLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.latitude)
            }
        }
    }
}
