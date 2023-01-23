//
//  NetworkViewControllerTest.swift
//  BikeNetworkTests
//
//  Created by Yash Udhlani on 17/08/22.
//

import XCTest
@testable import BikeNetwork

class NetworkViewControllerTest: XCTestCase {
    var stb: UIStoryboard!
    var controllerUnderTest: NetworkViewController!
    var networkModel: BikeNetworkModelDelegate!

    override func setUp() {
        stb = UIStoryboard(name: "Main", bundle: nil)
        controllerUnderTest = stb.instantiateViewController(identifier: "networkViewController") as? NetworkViewController
        controllerUnderTest.networkModel = MockBikeNetworkModel()
        controllerUnderTest.loadViewIfNeeded()
    }

    func testNetworkViewController_WhenCreated_SearchFieldEmpty () {
        XCTAssertEqual(controllerUnderTest?.searchNetwork.text, "")
    }

    func testNetworkViewController_WhenCreated_HasTableDelegateAndDatasource () {
        XCTAssertNotNil(controllerUnderTest?.networkTable)
        XCTAssertNotNil(controllerUnderTest?.networkTable.delegate)
        XCTAssertNotNil(controllerUnderTest?.networkTable.dataSource)
    }

    func testNetworkViewController_WhenCreated_ViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(controllerUnderTest.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(controllerUnderTest.responds(to: #selector(controllerUnderTest.tableView(_:didSelectRowAt:))))
    }

    func testNetworkViewController_WhenCreated_ViewConfromsToTableViewDatasourceProtocol() {
        XCTAssertTrue(controllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(controllerUnderTest.responds(to: #selector(controllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(controllerUnderTest.responds(to: #selector(controllerUnderTest.tableView(_:cellForRowAt:))))
    }

    func testNetworkViewController_WhenCreated_RendersCorrectData () {
        let cell = controllerUnderTest.tableView(controllerUnderTest.networkTable, cellForRowAt: IndexPath(row: 0, section: 0)) as? NetworkViewCell

        XCTAssertEqual(cell?.networkName.text, "Velobike")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
