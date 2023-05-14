//
//  CitiesView.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import SwiftUI

struct CitiesView: View {
    // State object to hold the view model
    @StateObject var citiesViewModel: CitiesViewModel    
    var body: some View {
        List {
            // Iterate through the cities in the view model and display each city in a row
            if citiesViewModel.currentCity != nil {
                self.createCityRowView(city: citiesViewModel.currentCity!, isCurrent: true)
            }
            ForEach(citiesViewModel.cities) { city in
                self.createCityRowView(city: city)
            }
            .onDelete(perform: deleteItem)
        }
        // Use a plain list style
        .listStyle(PlainListStyle())
    }
    
    private func deleteItem(at offsets: IndexSet) {
        citiesViewModel.performDelete(offsets: offsets)
    }
    
    private func createCityRowView(city: City, isCurrent: Bool = false) -> some View {
        ZStack {
            // Navigation link to the weather view for the selected city
            NavigationLink(destination: WeatherView(weatherViewModel: WeatherViewModel(city: city))) {
                EmptyView()
            }
            .opacity(0)
            
            // Display the city in a custom row view
            CityRowView(city: city, isCurrent: isCurrent)
                .background(Color.clear)
        }
        // Adjust the row insets and separator
        .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a view model with two mock cities and display the CitiesView
        let viewModel = CitiesViewModel()
        viewModel.cities.append(City.mockCity)
        viewModel.cities.append(City.mockCity)
        return CitiesView(citiesViewModel: viewModel)
    }
}
