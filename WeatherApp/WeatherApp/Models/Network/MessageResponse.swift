//
//  ErrorResponse.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation

struct MessageResponse: Decodable {    
    /// The message received from the server
    let message: String
    
    /// The status code received from the server
    let cod: String
}
