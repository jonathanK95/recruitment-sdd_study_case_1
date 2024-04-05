//
//  recruitment_sdd_study_case_1UITests.swift
//  recruitment-sdd_study_case_1UITests
//
//  Created by Jonathan Kristian on 03/04/24.
//

import XCTest

final class recruitment_sdd_study_case_1UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testTopUpController() throws {
        let app = XCUIApplication()
        app.launch()
        
        //Open History Controller
        app.buttons["History"].tap()
        var historyTable = app.tables.element(boundBy: 0)
        XCTAssertEqual(historyTable.cells.count, 3)
        
        //Open Top Up Controller
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.buttons["Top Up"].tap()
        app.buttons["Rp.100.000"].tap()
        app.buttons["Ok"].tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.buttons["History"].tap()
        historyTable = app.tables.element(boundBy: 0)
        XCTAssertEqual(historyTable.cells.count, 4)
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
