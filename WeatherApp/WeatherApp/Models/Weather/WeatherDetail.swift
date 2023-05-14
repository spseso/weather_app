//
//  WeatherDetail.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation

// Weather Detail model to store weather detailed information
struct WeatherDetail: Codable, Identifiable {
    var id: Int = 0 // The identifier for this weather detail
    var icon: String // The icon for this weather detail
    var description: String // A description of this weather detail
    var main: String // The main type of this weather detail (e.g. "Clear", "Rain")
    
    // Coding keys to map between the API's keys and our own
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case icon = "icon"
        case description = "description"
        case main = "main"
    }
}





