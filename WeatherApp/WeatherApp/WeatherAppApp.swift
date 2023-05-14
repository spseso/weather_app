//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(citiesViewModel: CitiesViewModel(), searchViewModel: SearchViewModel())
        }
    }
}
