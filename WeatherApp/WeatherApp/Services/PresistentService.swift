//
//  PersistenceService.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation
import CoreData

final class PersistenceService {
    // Singleton instance
    static let shared = PersistenceService()
    
    // NSPersistentContainer instance to manage Core Data stack
    let container: NSPersistentContainer

    // Initialize the persistent container with the given name, and load the persistent stores
    // Initialize default cities if necessary
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "WeatherAppDatabase")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { [weak self] _, error in
            guard let self = self else {
                return
            }
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            self.initializeDefaultCitiesIfNeeded()
        }
        
        // Automatically merge changes from the parent context
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // Fetch all cities from the persistent store
    func fetchCities() -> [CityEntity] {
        let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        do {
            let cities = try container.viewContext.fetch(request)
            return cities
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    // Add a new city to the persistent store
    @discardableResult
    func add(city: City) -> ValidationError? {
        // Only add the city if it does not already exist
        guard fetchCity(city: city) == nil else {
            return ValidationError.customError(ErrorStrings.somethingWrongError)
        }
        return addNewEntity(city: city)
    }
    
    // Create a new CityEntity instance and save it to the persistent store
    @discardableResult
    func addNewEntity(city: City) -> ValidationError? {
        let _ = CityEntity(city: city, context: container.viewContext)
        return saveContext()
    }
    
    // Add a new weather container entity to the city entity
    @discardableResult
    func addWeather(for city: City) -> ValidationError? {
        guard let cityEntity = fetchCity(city: city), let weatherResponse = city.weatherResponse else {
            return ValidationError.customError(ErrorStrings.somethingWrongError)
        }
        
        let newWeather = WeatherContainerEntity(context: container.viewContext)
        newWeather.city = cityEntity
        cityEntity.weather = newWeather
        
        if let wind = weatherResponse.wind {
            newWeather.wind = WindEntity(wind: wind, context: container.viewContext)
        }
        
        for detail in weatherResponse.weather {
            newWeather.addToWeather(WeatherDetailEntity(weatherDetail: detail, context: container.viewContext))
        }
        
        if let main = weatherResponse.main {
            newWeather.main = WeatherEntity(weather: main, context: container.viewContext)
        }
        
        return saveContext()
    }
    
    // Fetches the CityEntity corresponding to a given City object, if it exists in the database
    func fetchCity(city: City) -> CityEntity? {
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", city.name)
        
        do {
            // Executes the fetch request and returns the first matching CityEntity, if any
            let matchingCities = try container.viewContext.fetch(fetchRequest)
            return matchingCities.first
        } catch let error as NSError {
            // Prints an error message if the fetch request fails and returns nil
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }

    // Deletes a given CityEntity from the database
    @discardableResult
    func delete(city: City) -> ValidationError? {
        guard let cityEntity = fetchCity(city: city) else {
            return ValidationError.customError(ErrorStrings.somethingWrongError)
        }
        container.viewContext.delete(cityEntity)
        return saveContext()
    }
}

// MARK: - Private methods
extension PersistenceService {
    // Initializes the database with default CityEntity objects, if it's the first launch of the app
    private func initializeDefaultCitiesIfNeeded() {
        let isDefaultDataInitalized = UserDefaults.standard.bool(forKey: "is_default_data_initilized")
        if !isDefaultDataInitalized {
            // Adds a new CityEntity to the database for each city in the Constants file
            for city in CitiesConstants.cities {
                addNewEntity(city: city)
            }
            // Marks the database as initialized to prevent future redundant initialization
            UserDefaults.standard.set(true, forKey: "is_default_data_initilized")
        }
    }

    // Saves any changes made to the database
    @discardableResult
    private func saveContext() -> ValidationError? {
        do {
            try container.viewContext.save()
            return nil
        } catch let error as NSError {
            // Prints an error message if the save operation fails
            print("Could not save. \(error), \(error.userInfo)")
            return ValidationError.customError("Could not save. \(error), \(error.userInfo)")
        }
    }
}
