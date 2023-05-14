//
//  WeatherEntityExtension.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation
import CoreData

// Extension for WeatherEntity to convert to and from Weather model object
extension WeatherEntity {
    /// Convenience initializer to create a new `WeatherEntity` from a `Weather` object.
    /// - Parameters:
    ///   - weather: The `Weather` object to create the entity from.
    ///   - context: The `NSManagedObjectContext` to create the entity in.
    convenience init(weather: Weather, context: NSManagedObjectContext) {
        self.init(context: context)
        
        // Set the properties of the entity from the corresponding properties of the `Weather` object.
        self.id = weather.id
        self.temperature = weather.temperature
        self.feelsLike = weather.feelsLike
        self.humdidy = Int64(weather.humidity)
        self.pressure = Int64(weather.pressure)
    }
    
    /// Returns a `Weather` object created from the properties of the entity.
    func toWeather() -> Weather {
        Weather(
            temperature: temperature,
            feelsLike: feelsLike,
            pressure: Int(pressure),
            humidity: Int(humdidy)
        )
    }
}
