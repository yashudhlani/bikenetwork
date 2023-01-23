//
//  NetworkModelTests.swift
//  BikeNetworkTests
//
//  Created by Yash Udhlani on 13/08/22.
//

import XCTest
@testable import BikeNetwork

class NetworkModelTests: XCTestCase {
    var mockApiManager: MockApiManager!
    var networkModel: BikeNetworkModel!
    var mockNetworkViewDelegate: MockNetworkViewDelegate!

    override func setUp() {
        mockApiManager = MockApiManager()
        mockNetworkViewDelegate = MockNetworkViewDelegate()
        networkModel = BikeNetworkModel(mockApiManager, mockNetworkViewDelegate)
    }

    func testNetworkModel_WhenFetchNetworkisCalled_GetDataIsCalled () {

        networkModel.fetchNetworks()

        XCTAssertTrue(mockApiManager.isGetDataCalled, "getData method is not called")

    }

    func testNetworkModel_WhenFetchNetworkIsCalled_NetworkViewDelegateCalled () {
        mockApiManager.isNetworkCall = true

        let expectation = XCTestExpectation(description: "Delegate is Called")
        mockNetworkViewDelegate.expectation = expectation
        networkModel.fetchNetworks()

        self.wait(for: [expectation], timeout: 5)
    }

    func testNetworkModel_WhenFetchNetworkIsCalled_ShowErrorIsCalled () {
        mockApiManager.isErrorCall = true

        let expectation = XCTestExpectation(description: "Delegate is Called")
        mockNetworkViewDelegate.expectation = expectation
        networkModel.fetchNetworks()

        self.wait(for: [expectation], timeout: 5)
    }

    override func tearDown() {
        mockApiManager = nil
        networkModel = nil
    }

}
