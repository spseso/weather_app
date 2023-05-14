//
//  ValidationError.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

// An enum to represent various types of validation errors
enum ValidationError: Error {
    case serverError(String)
    case customError(String)
    case noInternet
}

extension ValidationError {
    // A helper method to get the error message for each case
    func getErrorMessage() -> String {
        switch self {
        case .serverError(let error):
            return error
        case .customError(let error):
            return error
        case .noInternet:
            return "The Internet connection appears to be offline."
        }
    }
}
