//
//  MockBikeNetworkModel.swift
//  BikeNetworkTests
//
//  Created by Yash Udhlani on 17/08/22.
//

import Foundation
@testable import BikeNetwork
import UIKit

class MockBikeNetworkModel: BikeNetworkModelDelegate {
    var delegate: BikeNetworkManagerDelegate!
    func fetchNetworks() {
        let data = [Network(name: "Velobike", href: "/v2/networks/Velobike", location: Location(city: "Moscow", country: "Russia", latitude: 30.0, longitude: 30.0))]
        self.delegate?.setNetwork(data)
    }
}


