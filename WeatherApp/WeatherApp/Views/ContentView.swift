//
//  ContentView.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import SwiftUI

struct ContentView: View {
    // State objects for the cities view model and search view model
    @StateObject var citiesViewModel: CitiesViewModel
    @StateObject var searchViewModel: SearchViewModel
    
    // State variable to keep track of whether to push the weather view or not
    @State private var shouldPushWeatherView = false
    
    var body: some View {
        NavigationStack {
            // Main content view with search and cities views
            VStack(spacing: 5) {
                // Search view for searching cities
                SearchView(searchViewModel: searchViewModel)
                    .padding([.leading, .trailing], 10)
                
                // View for displaying cities
                CitiesView(citiesViewModel: citiesViewModel)
            }
            // Navigation destination for pushing WeatherView
            .navigationDestination(isPresented: $shouldPushWeatherView) {
                // Weather view with the found city
                WeatherView(weatherViewModel: WeatherViewModel(city: searchViewModel.foundCity!))
            }
            // Navigation bar customizations
            .navigationBarTitle("Weather", displayMode: .large)
            .navigationBarTitleTextColor(.white)
            // Background color of the main view
            .background(Rectangle()
                .fill(.mint).ignoresSafeArea())
            // Handle found city from search view model and push the weather view if necessary
            .onReceive(searchViewModel.$foundCity) { city in
                if let city {
                    citiesViewModel.addNewCity(city: city)
                }
                shouldPushWeatherView = city != nil
            }
            .alert(searchViewModel.error?.getErrorMessage() ?? "", isPresented: $searchViewModel.hasError) {
                Button(Strings.okButtonTitle, role: .cancel) {
                    searchViewModel.error = nil
                }
            }
            .alert(citiesViewModel.error?.getErrorMessage() ?? "", isPresented: $citiesViewModel.hasError) {
                Button(Strings.okButtonTitle, role: .cancel) {
                    citiesViewModel.error = nil
                }
            }
        }        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview with cities view model and search view model
        let viewModel = CitiesViewModel()
        viewModel.cities.append(City.mockCity)
        viewModel.cities.append(City.mockCity)
        viewModel.cities.append(City.mockCity)
        return ContentView(citiesViewModel: viewModel, searchViewModel: SearchViewModel())
    }
}
