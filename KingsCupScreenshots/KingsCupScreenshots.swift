//
//  KingsCupUITests.swift
//  KingsCupUITests
//
//  Created by Adam Haafiz on 28/07/2019.
//  Copyright © 2019 Adam Haafiz. All rights reserved.
//

import XCTest
import KingsCupData

class KingsCupScreenshots: XCTestCase {
    override func setUp() {
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchArguments.append("Screenshots")
        setupSnapshot(app)
        app.launch()
    }

    func testTakeScreenshots() {
        let app = XCUIApplication()
        snapshot("4")
        app/*@START_MENU_TOKEN@*/.buttons["MainMenuGuideButton"]/*[[".buttons[\"Kurzanleitung\"]",".buttons[\"MainMenuGuideButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("5")
        app.buttons.firstMatch.tap()
        app.buttons["MainMenuStartButton"].tap()

        let firstCell = app.collectionViews.cells.firstMatch
        let checkedButton = app.buttons["checked"]

        for i in 1...4 {
            firstCell.tap()

            if i == 3 {
                snapshot("2")
            }

            checkedButton.tap()

            if i == 2 {
                snapshot("1")
            } else if i == 4 {
                snapshot("3")
            }
        }
    }
}
