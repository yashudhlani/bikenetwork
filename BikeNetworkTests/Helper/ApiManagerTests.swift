//
//  ApiManagerTests.swift
//  BikeNetworkTests
//
//  Created by Yash Udhlani on 12/08/22.
//

import XCTest
@testable import BikeNetwork

class ApiManagerTests: XCTestCase {
    var manager: ApiManager!
    let url = URL(string: "https://api.citybik.es/v2/networks")!
    var expectaion: XCTestExpectation!

    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockUrlProtocol.self]
        let urlSession = URLSession(configuration: config)
        manager = ApiManager(urlSession)
    }

    func testApiManager_WhenBikeNetworksCallIsSuccessfull_SuccessfullJsonParse() {
        let networkData = """
                            {
                                "networks": [{
                                    "name": "Velobike",
                                    "href": "/v2/network/velobike-moscow",
                                    "location": {
                                        "city": "Moscow",
                                        "country": "RU",
                                        "latitude": \(34.0),
                                        "longitude": \(40.0)
                                    }
                                }]
                            }
                            """
        let mockData = networkData.data(using: .utf8)
        MockUrlProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
          return (response, mockData)
        }

        expectaion = self.expectation(description: "Api should return list of networks")

        manager.getData(url, Networks.self) { data, error in
            XCTAssertEqual(data!.networks[0].name, "Velobike")
            XCTAssertEqual(data!.networks[0].href, "/v2/network/velobike-moscow")
            XCTAssertEqual(data!.networks[0].location.city, "Moscow")
            XCTAssertEqual(data!.networks[0].location.country, "RU")

            XCTAssertNil(error)

            self.expectaion.fulfill()
        }

        self.wait(for: [expectaion], timeout: 10)
    }

    func testApiManager_WhenBikeNetworksCallIsSuccessfull_UnsuccessfullJsonParse() {
        let networkData = """
                            {
                                "networks": [{
                                    "name": "Velobike",
                                    "href": "/v2/network/velobike-moscow"
                                }]
                            }
                            """
        let mockData = networkData.data(using: .utf8)
        MockUrlProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
          return (response, mockData)
        }

        expectaion = self.expectation(description: "Api should return list of networks")

        manager.getData(url, Networks.self) { data, error in
            XCTAssertNil(data)
            if let error = error as? ApiError {
                XCTAssertEqual(error.errorDescription, "Somethings wrong with json")
            }
            self.expectaion.fulfill()
        }

        self.wait(for: [expectaion], timeout: 10)
    }

    override func tearDown() {
        manager = nil
        expectaion = nil
    }
}
