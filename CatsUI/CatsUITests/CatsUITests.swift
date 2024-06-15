//
//  CatsUITests.swift
//  CatsUITests
//
//  Created by Zakhar Litvinchuk on 09.06.2024.
//

import XCTest

final class CatsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor 
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        sleep(3)
        snapshot("Zakhar_MainScreen")
        let _ = app.descendants(matching: .any)["AnimalsList"].tap()
        sleep(3)
        snapshot("Zakhar_DetailsScreen")
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
