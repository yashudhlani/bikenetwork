//
//  Station.swift
//  BikeNetwork
//
//  Created by Yash Udhlani on 02/08/22.
//

import Foundation

struct NetworkInfo: Codable {
    var network: Network
}

struct Station: Codable {
    var emptySlots: Int?
    var name: String
    var latitude: Double
    var longitude: Double
    var freeBikes: Int?
    var extra: Extra

    enum CodingKeys: String, CodingKey {
        case name, latitude, longitude, extra
        case emptySlots = "empty_slots"
        case freeBikes = "free_bikes"
    }
}

struct Extra: Codable {
    var address: String?
    var placement: String?
}
