//
//  NetworkProtocol.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation
import Alamofire
import Combine
/// A protocol that defines a network interface.
protocol NetworkProtocol {
    
    /// The headers to be used in every request.
    static var headers: HTTPHeaders { get }
    
    /// Sends a request to a given endpoint and returns the response in a publisher.
    /// - Parameters:
    ///   - endpoint: The endpoint to send the request to.
    ///   - method: The HTTP method to use.
    ///   - parameters: The parameters to include in the request.
    ///   - encoding: The encoding to use for the parameters.
    ///   - headers: Additional headers to include in the request.
    ///   - interceptor: The request interceptor to use.
    ///   - type: The expected type of the response.
    /// - Returns: A publisher that emits the response and any validation errors.
    static func request<T: Decodable>(endpoint: EndpointType,
                                      method: HTTPMethod,
                                      parameters: Parameters?,
                                      encoding: ParameterEncoding,
                                      headers: HTTPHeaders?,
                                      interceptor: RequestInterceptor?,
                                      type: T.Type) -> AnyPublisher<DataResponse<T, ValidationError>, Never>
}
