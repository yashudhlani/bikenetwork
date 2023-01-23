//
//  ApiError.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 13/08/22.
//

import Foundation

enum ApiError: LocalizedError {
    case jsonParseError
    case networkError

    var errorDescription: String? {
        switch self {
        case .jsonParseError: return "Somethings wrong with json"
        case .networkError: return "Network Error"
        }
    }
}
