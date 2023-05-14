//
//  WindEntityExtension.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation
import CoreData

// Extension for WindEntity to convert to and from Wind model object
extension WindEntity {
    // Convenience initializer to create a WindEntity object from a Wind object
    /// - Parameters:
    ///   - wind: The `Wind` object to create the entity from.
    ///   - context: The `NSManagedObjectContext` to create the entity in.
    convenience init(wind: Wind, context: NSManagedObjectContext) {
        self.init(context: context)
        self.deg = wind.deg
        self.speed = wind.speed
    }
    
    // Helper method to convert WindEntity object to Wind object
    func toWind() -> Wind {
        Wind(speed: speed, deg: deg)
    }
    
}
