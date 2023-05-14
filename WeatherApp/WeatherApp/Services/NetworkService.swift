//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation
import Alamofire
import Combine

/// A network service that conforms to the `NetworkProtocol` protocol and performs network requests using Alamofire.
struct NetworkService: NetworkProtocol {
    
    /// Default HTTP headers to be used in network requests.
    static var headers: HTTPHeaders {
        [.defaultUserAgent,
         .defaultAcceptLanguage,
         .contentType(ApiKeysConstants.contentType),
         .accept(ApiKeysConstants.contentType)]
    }
    
    /// A function that sends a network request to the given endpoint with the given parameters and encoding,
    /// and returns a publisher that emits a response as a `DataResponse<T, ValidationError>` object.
    /// - Parameters:
    ///   - endpoint: An `EndpointType` object representing the endpoint to send the request to.
    ///   - method: The HTTP method to use in the request. Defaults to `.get`.
    ///   - parameters: The parameters to include in the request. Defaults to `nil`.
    ///   - encoding: The encoding to use for the parameters. Defaults to `JSONEncoding.default`.
    ///   - headers: The HTTP headers to include in the request. Defaults to `headers`.
    ///   - interceptor: An optional `RequestInterceptor` to intercept the request.
    ///   - type: The expected type of the response. Must be `Decodable`.
    /// - Returns: A publisher that emits a response as a `DataResponse<T, ValidationError>` object.
    static func request<T: Decodable>(endpoint: EndpointType,
                                      method: HTTPMethod = .get,
                                      parameters: Parameters? = nil,
                                      encoding: ParameterEncoding = JSONEncoding.default,
                                      headers: HTTPHeaders? = headers,
                                      interceptor: RequestInterceptor? = nil,
                                      type: T.Type)
    -> AnyPublisher<DataResponse<T, ValidationError>, Never> {
        return AF.request(endpoint.fullUrl, method: method,
                          parameters: parameters,
                          encoding: encoding,
                          headers: headers,
                          interceptor: interceptor)
        .validate()
        .publishDecodable(type: T.self)
        .map { response in
            response.mapError { error in
                return mapError(error: error)
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    /// Cancels all current network tasks.
    static func cancelAllTasks() {
        Alamofire.Session.default.session.getTasksWithCompletionHandler({ dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        })
    }
}

// MARK: - Private methods
extension NetworkService {    
    /// Maps an `AFError` to a `ValidationError`.
    /// - Parameter error: The `AFError` to map.
    /// - Returns: A `ValidationError` that corresponds to the given error.
    private static func mapError(error: AFError) -> ValidationError {
        if let validError = error.underlyingError as? ValidationError {
            return validError
        } else {
            print(error)
            if let nsError = error.underlyingError as? NSError,
               let underlyingError = nsError.userInfo["NSUnderlyingError"] as? NSError,
               underlyingError.code == NSURLErrorNotConnectedToInternet {
                return .noInternet
            }
            return .customError(error.localizedDescription)
        }
    }
}
