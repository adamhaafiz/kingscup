//
//  KingsCupUITests.swift
//  KingsCupUITests
//
//  Created by Adam Haafiz on 28/07/2019.
//  Copyright © 2019 Adam Haafiz. All rights reserved.
//

import XCTest

class KingsCupUITests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchArguments.append("UITests")
        app.launch()
    }

    func testEntireGameFlow() {
        let app = XCUIApplication()
        app.buttons["MainMenuStartButton"].tap()

        let firstCell = app.collectionViews.cells.firstMatch
        let checkedButton = app.buttons["checked"]

        for _ in 1...13 {
            firstCell.tap()
            checkedButton.tap()
        }

        let kings = ["K diamonds", "K hearts", "K spades"]
        for king in kings {
            while app.collectionViews.cells.otherElements.containing(.staticText, identifier:king).count == 0 {
                firstCell.swipeLeft()
            }

            app.collectionViews.cells.otherElements.containing(.staticText, identifier:king).element.tap()
            checkedButton.tap()
        }

        app.buttons["menu"].tap()
    }

    func testGuides() {
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.buttons["MainMenuGuideButton"]/*[[".buttons[\"Kurzanleitung\"]",".buttons[\"MainMenuGuideButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.staticTexts.element(boundBy: 1).swipeLeft()
        app.staticTexts.element(boundBy: 1).swipeLeft()
    }
}
