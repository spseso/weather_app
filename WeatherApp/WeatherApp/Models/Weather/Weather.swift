//
//  Weather.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation

// Weather model to store weather information
struct Weather: Codable, Identifiable {
    var temperature: Double // temperature in Celsius
    var feelsLike: Double // feels like temperature in Celsius
    var pressure: Int // atmospheric pressure in hPa
    var humidity: Int // humidity in percentage
    var id: UUID = UUID() // unique identifier for each Weather object
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
    }

    // Helper method to create a mock Weather object for testing purposes
    static func mock() -> Weather {
        Weather(temperature: 0.0,
                feelsLike: 0,
                pressure: 0,
                humidity: 0)
    }
}
