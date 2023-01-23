//
//  MockApiManager.swift
//  BikeNetworkTests
//
//  Created by Yash Udhlani on 14/08/22.
//

import Foundation
@testable import BikeNetwork

class MockApiManager: ApiManagerProtocol {

    var isGetDataCalled: Bool = false
    var isNetworkCall: Bool = false
    var isErrorCall: Bool = false

    func getData<T: Codable>(_ url: URL, _ type: T.Type, onCompletion: @escaping (T?, Error?) -> Void) {
        isGetDataCalled = true
        if isErrorCall {
            onCompletion(nil, ApiError.networkError)
            return
        }

        if isNetworkCall {
            let data = Networks(networks: [Network(name: "Velobike", href: "/v2/networks/Velobike", location: Location(city: "Moscow", country: "Russia", latitude: 30.0, longitude: 30.0))])
            onCompletion(data as? T, nil)
        } else {
            let data = NetworkInfo(network: Network(name: "Velobike", href: "/v2/networks/Velobike", location: Location(city: "Moscow", country: "Russia", latitude: 30.0, longitude: 30.0)))
            onCompletion(data as? T, nil)
        }
    }
}
