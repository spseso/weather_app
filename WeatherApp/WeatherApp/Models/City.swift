//
//  City.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation

// City model to store city information
final class City: Identifiable {
    // Unique identifier of a city based on its name, longitude, and latitude.
    var id: String {
        return "\(name)\(longitude)\(latitude)"
    }
    
    // Name of the city.
    var name: String
    
    // Longitude and latitude coordinates of the city.
    var longitude: Double
    var latitude: Double
    
    // The weather response for the city obtained from the API.
    var weatherResponse: WeatherResponse?
    
    init(name: String, longitude: Double, latitude: Double, weatherResponse: WeatherResponse? = nil) {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.weatherResponse = weatherResponse
    }
    
    // A mock city object with default values for testing purposes.
    static let mockCity: City = {
        City(name: "Mock City", longitude: 0, latitude: 0)
    }()
}
