//
//  MockStationViewDelegate.swift
//  BikeNetworkTests
//
//  Created by Yash Udhlani on 14/08/22.
//

import Foundation
@testable import BikeNetwork
import XCTest

class MockStationViewDelegate: BikeStationManagerDelegate {
    var expectation: XCTestExpectation!

    func updateStations(_ network: Network) {
        expectation.fulfill()
    }
    func showError(_ error: Error) {
        expectation.fulfill()
    }
}
