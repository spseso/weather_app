//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/13/23.
//

import Foundation
import Combine

// ViewModel for managing weather data
final class WeatherViewModel: ObservableObject {
    // The city object whose weather data is being displayed
    var city: City
    
    // The error occurred while fetching weather data
    @Published var error: ValidationError? = nil {
        didSet {
            hasError = error != nil
        }
    }
    
    // Indicates if there is an error occurred while fetching weather data
    var hasError: Bool = false
    
    // The cancelables set to keep track of network requests
    private var cancelables = Set<AnyCancellable>()
        
    
    // Initializes the view model with the given city object
    init(city: City) {
        self.city = city
    }
    
    // Fetches the weather data for the city from the API
    public func fetchWeatherData() {
        NetworkService.request(endpoint: WeatherAppApi.weather(latitude: city.latitude, longitude: city.longitude),
                               type: WeatherResponse.self)
            .sink { (dataResponse) in
                if let error = dataResponse.error {
                    self.error = error
                } else {
                    // Updates the weather data for the city and saves it to the persistent store
                    self.city.weatherResponse = dataResponse.value!
                    self.error = PersistenceService.shared.addWeather(for: self.city)
                }
            }.store(in: &cancelables)
    }
    
    // Returns the wind speed in km/h as a formatted string
    var windSpeed: String {
        return String(format: "%0.1f", city.weatherResponse?.wind?.speed ?? "-")
    }
    
    // Returns the humidity percentage as a formatted string
    var humidity: String {
        return String(format: "%d%%", city.weatherResponse?.main?.humidity ?? "-")
    }
    
    // Returns the temperature in Celsius as a formatted string
    var temperature: String {
        return String(format: "%1.0f", city.weatherResponse?.main?.temperature ?? "-")
    }
    
    // Returns the feels like temperature in Celsius as a formatted string
    var feelsLike: String {
        return String(format: "%1.0f", city.weatherResponse?.main?.feelsLike ?? "-")
    }
    
    // Returns the weather icon name
    var iconName: String {
        return city.weatherResponse?.weather.first?.icon ?? "sun"
    }
}
