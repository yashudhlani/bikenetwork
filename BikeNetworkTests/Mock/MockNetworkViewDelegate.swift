//
//  MockNetworkViewDelegate.swift
//  BikeNetworkTests
//
//  Created by Yash Udhlani on 14/08/22.
//

import Foundation
@testable import BikeNetwork
import XCTest

class MockNetworkViewDelegate: BikeNetworkManagerDelegate {

    var expectation: XCTestExpectation!
    func setNetwork(_ networks: [Network]) {
        expectation.fulfill()
    }
    func showError(_ error: Error) {
        expectation.fulfill()
    }
}
