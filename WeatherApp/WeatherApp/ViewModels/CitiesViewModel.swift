//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/12/23.
//

import SwiftUI
import CoreData

// ViewModel for managing cities data
final class CitiesViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    // List of cities retrieved from the database
    var cities: [City] = []
    
    // Current city based on user's location
    @Published var currentCity: City? = nil
    
    // LocationService instance to get the user's location
    var locationService: LocationService = LocationService()
    
    // MARK: - Initializer
    
    // Initializes the ViewModel and configures cities from the database
    override init() {
        super.init()
        configureCitiesFromDB()
        locationService.delegate = self
        locationService.startUpdatingLocation()
    }
    
    // MARK: - Public methods
    
    // Adds a new city to the database and reloads cities from the database
    func addNewCity(city: City) {
        self.error = PersistenceService.shared.add(city: city)
        configureCitiesFromDB()
    }
    
    // Adds a new city to the database and reloads cities from the database
    func performDelete(offsets: IndexSet) {
        for index in offsets {
            let deleteCity = cities[index]
            self.error = PersistenceService.shared.delete(city: deleteCity)
            configureCitiesFromDB()
        }
    }
    
    // MARK: - Private methods
    
    // Fetches cities from the database and updates the cities list
    private func configureCitiesFromDB() {
        self.cities = PersistenceService.shared.fetchCities().compactMap({ $0.name != currentCity?.name ? $0.toCity() : nil }).reversed()
    }
}

// MARK: - LocationServiceDelegate

extension CitiesViewModel: LocationServiceDelegate {
    
    // Called when city is not found for the user's current location
    func cityNotFoundForLocation(latitude: Double, longitude: Double) {
        locationService.startUpdatingLocation()
    }
    
    // Called when user's current location is found
    func currentLocationFound(latitude: Double, longitude: Double) {
        // Do nothing for now
    }
    
    // Called when user's current city is found
    func currentCityFound(city: City) {
        if let index = cities.firstIndex(where: {$0.name == city.name}) {
            self.currentCity = cities[index]
            cities.remove(at: index)
        } else {
            self.currentCity = city
            PersistenceService.shared.add(city: city)
        }
    }
}
