//
//  BikeNetworkUITests.swift
//  BikeNetworkUITests
//
//  Created by Yash Udhlani on 18/08/22.
//

import XCTest

class BikeNetworkUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkTableExists () {
        let networkTable = app.tables["networkTable"]
        XCTAssertTrue(networkTable.exists)
    }

    func testNetworkTable_SearchExists () {
        let searchCitiesSearchField = app.searchFields["Search Cities"]
        searchCitiesSearchField.tap()

        XCTAssertTrue(searchCitiesSearchField.isEnabled, "Search field is not enabled for user interaction")
    }

    func testNetworkTable_SearchWorks() throws {
        let searchCitiesSearchField = app.searchFields["Search Cities"]

        searchCitiesSearchField.tap()
        searchCitiesSearchField.typeText("Velobike")

        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()

        let networkTable = app.tables["networkTable"]
        let velobikePredicate = NSPredicate(format: "label beginswith 'Velobike'")
        let velobikeCell = networkTable.cells.staticTexts.element(matching: velobikePredicate)
        let bycyklenPredicate = NSPredicate(format: "label beginswith 'Bycyklen'")
        let bycyklenCell = networkTable.cells.staticTexts.element(matching: bycyklenPredicate)

        XCTAssertTrue(velobikeCell.exists)
        XCTAssertFalse(bycyklenCell.exists)
        // XCUIApplication().navigationBars["BikeNetwork.StationView"].buttons["Back"].tap()
    }

    func testNetworkTable_CellTabWorks() {
        let networkTable = app.tables["networkTable"]
        let velobike = networkTable.cells.element(boundBy: 0)
        velobike.tap()

        let stationTable = app.collectionViews["stationCollection_Velobike"]

        XCTAssertTrue(stationTable.exists)
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
