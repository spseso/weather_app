//
//  WeatherAppApi.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation
import Alamofire

// An enum representing the available API endpoints for the WeatherApp
public enum WeatherAppApi {
    // Enum cases representing each available endpoint
    case none  // No endpoint
    case weather(latitude: Double, longitude: Double)  // Endpoint to retrieve weather data
}

extension WeatherAppApi: EndpointType {
    // Base URL for the OpenWeatherMap API
    public var baseURL: URLConvertible {
        return "https://api.openweathermap.org/data/2.5"
    }
    
    // Full URL for the endpoint, including the base URL, path, units, and API key
    public var fullUrl: URLConvertible {
        return "\(baseURL)\(path)&units=metric&appid=\(Constants.openWeatherMapApiKey)"
    }

    // Path for the endpoint, depending on the case of the WeatherAppApi enum
    public var path: URLConvertible {
        switch self {
        case .none:
            return "" // No path for the "none" case
        case .weather(let latitude, let longitude):
            return "/weather?lat=\(latitude)&lon=\(longitude)&exclude=minutely" // Path for the "weather" case
        }
    }
}
