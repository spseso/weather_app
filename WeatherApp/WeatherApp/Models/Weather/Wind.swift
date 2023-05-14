//
//  Wind.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation

// Wind model to store wind information
struct Wind: Codable {
    let speed: Double   // Wind speed in meters per second
    let deg: Double     // Wind direction, in degrees (meteorological)

    // A convenience method to create a mock `Wind` object with default values of 0.0
    static func mock() -> Wind {
        Wind(speed: 0.0, deg: 0.0)
    }
}
