//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation
import CoreLocation

// ViewModel for search functionality
final class SearchViewModel: BaseViewModel {
    // Published property to hold the user's search query
    @Published var searchCity = ""

    // Published property to hold the found city after performing the search
    @Published var foundCity: City? = nil        

    // Function to perform a search using CoreLocation geocoder
    func performSearch() {
        // Use CLGeocoder to geocode the user's search query
        CLGeocoder().geocodeAddressString(searchCity) { (placemarks, error) in
            if let places = placemarks,
               let place = places.first,
               let location = place.location {
                // Create a City object with the found location and assign it to foundCity property
                self.foundCity = City(name: self.searchCity, longitude: location.coordinate.longitude, latitude: location.coordinate.latitude)
                
                // Reset searchCity property after successful search
                self.searchCity = ""
            } else {
                self.error = ValidationError.customError(ErrorStrings.notFoundCityError)
            }
        }
    }
}
