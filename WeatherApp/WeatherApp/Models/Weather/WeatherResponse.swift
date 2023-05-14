//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation

// Weather Response model to store weather combined information
struct WeatherResponse: Codable {
    var main: Weather?   // The main weather data object
    var weather: [WeatherDetail]   // An array of weather details
    var wind: Wind?   // The wind data object

    // A mock data generator for testing purposes
    static func mock() -> WeatherResponse {
        WeatherResponse(main: Weather.mock(), weather: [], wind: Wind(speed: 0.0, deg: 0.0))
    }
}
