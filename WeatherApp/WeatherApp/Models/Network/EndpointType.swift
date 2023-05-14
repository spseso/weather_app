//
//  EndpointType.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation
import Alamofire

public protocol EndpointType {
    // The base URL of the endpoint
    var baseURL: URLConvertible { get }
    
    // The path component of the endpoint URL
    var path: URLConvertible { get }
    
    // The full URL of the endpoint, including the base URL and path
    var fullUrl: URLConvertible { get }
}
