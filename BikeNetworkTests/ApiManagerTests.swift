//
//  ApiManagerTests.swift
//  BikeNetworkTests
//
//  Created by Yash Udhlani on 12/08/22.
//

import XCTest
@testable import BikeNetwork

class ApiManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApiManager_WhenBikeNetworksCallIsSuccessfull_ReturnsSuccess() {
        let manager = ApiManager()
        let expectaion = self.expectation(description: "Api should return list of networks")

        manager.getData(URL(string: "https://api.citybik.es/v2/networks")!, Networks.self) { data in
            XCTAssertEqual(data.networks[0].name, "Velobike")
            expectaion.fulfill()
        }

        self.wait(for: [expectaion], timeout: 5)
    }
}
