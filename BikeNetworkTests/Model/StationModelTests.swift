//
//  StationModelTests.swift
//  BikeNetworkTests
//
//  Created by Yash Udhlani on 14/08/22.
//

import XCTest
@testable import BikeNetwork

class StationModelTests: XCTestCase {
    var mockApiManager: MockApiManager!
    var stationModel: BikeStationModel!
    var mockStationViewDelegate: MockStationViewDelegate!

    override func setUp() {
        mockApiManager = MockApiManager()
        stationModel = BikeStationModel(mockApiManager)
        mockStationViewDelegate = MockStationViewDelegate()
    }

    func testNetworkModel_WhenFetchNetworkisCalled_GetDataIsCalled () {

        stationModel.fetchStations(URL(string: "v2/network/stations")!)

        XCTAssertTrue(mockApiManager.isGetDataCalled, "getData method is not called")

    }

    func testStationModel_WhenUpdateStationsIsCalled_StationViewDelegateCalled () {

        let expectation = XCTestExpectation(description: "Delegate is Called")
        mockStationViewDelegate.expectation = expectation
        stationModel.delegate = mockStationViewDelegate
        stationModel.fetchStations(URL(string: "v2/network/stations")!)

        self.wait(for: [expectation], timeout: 5)
    }

    func testStationModel_WhenUpdateStationsIsCalled_ShowErrorIsCalled () {
        mockApiManager.isErrorCall = true

        let expectation = XCTestExpectation(description: "Delegate is Called")
        mockStationViewDelegate.expectation = expectation
        stationModel.delegate = mockStationViewDelegate
        stationModel.fetchStations(URL(string: "v2/network/stations")!)

        self.wait(for: [expectation], timeout: 5)
    }

    override func tearDown() {
        mockApiManager = nil
        stationModel = nil
        mockStationViewDelegate = nil
    }

}
