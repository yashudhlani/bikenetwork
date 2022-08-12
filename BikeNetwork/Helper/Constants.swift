//
//  Constants.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 09/08/22.
//

import Foundation

class Contants {
    static let DOMAIN = "https://api.citybik.es"
    static let NETWORKENDPOINT = "/v2/networks"

    static func getNetworkUrl() -> URL {
        return URL(string: String("\(DOMAIN)\(NETWORKENDPOINT)"))!
    }
}
