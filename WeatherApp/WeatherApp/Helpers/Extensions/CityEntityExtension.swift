//
//  CityEntityExtension.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation
import CoreData

// Extension for CityEntity to convert to and from City model objec
extension CityEntity {
    // Convenience initializer to create a new CityEntity instance from a City model object.
    /// - Parameters:
    ///   - city: The `City` object to create the entity from.
    ///   - context: The `NSManagedObjectContext` to create the entity in.
    convenience init(city: City, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = city.id
        self.longitude = city.longitude
        self.latitude = city.latitude
        self.name = city.name
    }
    
    // Function to convert a CityEntity instance to a City model object.
    func toCity() -> City {
        var weatherResponse: WeatherResponse? = nil
        if let weatherContainer = weather {
            let wind = weatherContainer.wind?.toWind()
            var details: [WeatherDetail] = []
            // Loop through all WeatherDetailEntity objects in the weather relationship, converting them to WeatherDetail objects.
            for detailEntity in weatherContainer.weather! where detailEntity is WeatherDetailEntity {
                let detail = (detailEntity as! WeatherDetailEntity).toWeatherDetail()
                details.append(detail)
            }
            let main = weatherContainer.main?.toWeather()
            weatherResponse = WeatherResponse(main: main ?? Weather.mock(), weather: details, wind: wind ?? Wind(speed: 0, deg: 0))
        }
        return City(name: name ?? "", longitude: longitude, latitude: latitude, weatherResponse: weatherResponse)
    }
}
