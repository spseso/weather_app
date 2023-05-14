//
//  BaseViewModel.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation
import SwiftUI

// `BaseViewModel` is a class that implements common functionality used by other view models.
class BaseViewModel: ObservableObject {
    
    // `hasError` indicates if there is an error occurred while fetching weather data.
    var hasError: Bool = false
    
    // `error` represents the error occurred while fetching weather data.
    // This property is marked with `@Published` to allow for automatic UI updates when the value changes.
    @Published var error: ValidationError? = nil {
        didSet {
            // Update `hasError` when `error` changes.
            hasError = error != nil
        }
    }
    
}
