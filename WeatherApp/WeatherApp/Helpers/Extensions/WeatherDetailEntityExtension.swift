//
//  WeatherDetailEntityExtension.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation
import CoreData

// Extension for WeatherDetailEntity to convert to and from WeatherDetail model object
extension WeatherDetailEntity {
    // Convenience initializer to create a WeatherDetailEntity object from a WeatherDetail object
    /// - Parameters:
    ///   - weatherDetail: The `WeatherDetail` object to create the entity from.
    ///   - context: The `NSManagedObjectContext` to create the entity in.
    convenience init(weatherDetail: WeatherDetail, context: NSManagedObjectContext) {
        self.init(context: context)
        self.icon = weatherDetail.icon
        self.desc = weatherDetail.description
        self.main = weatherDetail.main
    }
    
    // Helper method to convert WeatherDetailEntity object to WeatherDetail object
    func toWeatherDetail() -> WeatherDetail {
        WeatherDetail(icon: icon ?? "", description: desc ?? "", main: main ?? "")
    }
}
