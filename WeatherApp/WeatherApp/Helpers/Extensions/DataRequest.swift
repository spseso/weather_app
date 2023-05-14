//
//  DataRequest.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import Foundation
import Alamofire

// This extension provides methods for validating response status and content type of Alamofire DataRequests
extension DataRequest {
    // Validates the response status code and content type of the DataRequest
    @discardableResult
    public func customValidation() -> Self {
        return validateStatus().validate(contentType: [ApiKeysConstants.contentType])
    }
    
    // Validates the response status code of the DataRequest
    @discardableResult
    public func validateStatus() -> Self {
        return validate { [unowned self] (request, response, data) -> DataRequest.ValidationResult in
            self.validate(request, response, data)
        }
    }
    
    // Validates the response status code and handles any errors that may occur
    fileprivate func validate(_ request: URLRequest?, _ response: HTTPURLResponse, _ data: Data?) -> ValidationResult {
        if !ApiKeysConstants.acceptableStatusCodes.contains(response.statusCode) {
            // If the response code is not in the acceptable status codes range
            if let data = data,
               let messResponse = try? JSONDecoder().decode(MessageResponse.self, from: data) {
                // If there is a message in the response data, return a server error message
                return .failure(ValidationError.serverError(messResponse.message))
            } else {
                // If there is no message in the response data, return a custom error message with the status code description
                return .failure(ValidationError.customError(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)))
            }
        }
        // If the response code is within the acceptable range, return a success message
        return .success(Void())
    }
}
