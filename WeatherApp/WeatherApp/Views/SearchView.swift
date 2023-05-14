//
//  SearchView.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import SwiftUI

struct SearchView: View {
    // Create a state object of SearchViewModel
    @StateObject var searchViewModel: SearchViewModel
    
    var body: some View {
        HStack {
            // Create a TextField to enter a city name and bind it to the searchViewModel
            TextField("Search for a city", text: $searchViewModel.searchCity)
                .padding(.leading, 10)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .foregroundColor(.mint)
                .onSubmit {
                    // Call performSearch() method on submit
                    searchViewModel.performSearch()
                }
            
            // Create a button to trigger the search action and bind it to the searchViewModel
            Button {
                searchViewModel.performSearch()
            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.mint)
                    .frame(width: 20, height: 20)
                    .padding(10)
            }
        }
        .background(
            // Create a rounded rectangle background for the search bar
            RoundedRectangle(cornerRadius: 14)
                .fill(.white)
        )
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchViewModel: SearchViewModel())
    }
}
