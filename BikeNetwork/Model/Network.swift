//
//  Network.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 01/08/22.
//

import Foundation

struct Networks: Codable {
    var networks: [Network]
}

struct Network: Codable {
    var name: String
    // var company: String?
    var href: String
    var location: Location
    var stations: [Station]?
}

struct Location: Codable {
    var city: String
    var country: String
    var latitude: Double
    var longitude: Double
}
