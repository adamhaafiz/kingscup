//
//  KingsCupUITests.swift
//  KingsCupUITests
//
//  Created by Adam Haafiz on 28/07/2019.
//  Copyright © 2019 Adam Haafiz. All rights reserved.
//

import XCTest
import KingsCupData

class KingsCupUITests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchArguments.append("UITests")
        setupSnapshot(app)
        app.launch()
    }

    func testDisplayAllActionsTypes() {
        let app = XCUIApplication()
        app.buttons["MainMenuStartButton"].tap()

        let firstCell = app.collectionViews.cells.firstMatch
        let checkedButton = app.buttons["checked"]

        for actionType in ActionType.allCases {
            firstCell.tap()
            snapshot("Action Type \(ActionType.allCases.firstIndex(of: actionType)!) - \(actionType.rawValue)")
            checkedButton.tap()
        }
    }

    func testGameWinScenario() {
        let app = XCUIApplication()
        app.buttons["MainMenuStartButton"].tap()

        let checkedButton = app.buttons["checked"]

        let kings = ["K clubs", "K diamonds", "K hearts", "K spades"]
        for king in kings {
            while app.collectionViews.cells.otherElements.containing(.staticText, identifier:king).count == 0 {
                app.collectionViews.element.swipeLeft()
            }

            app.collectionViews.cells.otherElements.containing(.staticText, identifier:king).element.tap()

            // UITests are a bit flaky, sometimes it'll try to tap the checkedButton too soon
            if !checkedButton.exists {
                sleep(1)
            }

            checkedButton.tap()
            snapshot("King \(kings.firstIndex(of: king)! + 1)")
        }

        sleep(1)
        snapshot("Game Over")
        app.buttons["menu"].tap()
        snapshot("Game Menu")
    }

    func testGuides() {
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.buttons["MainMenuGuideButton"]/*[[".buttons[\"Kurzanleitung\"]",".buttons[\"MainMenuGuideButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("Guide 1")
        app.staticTexts["GuidePageGuideTitle"].swipeLeft()
        snapshot("Guide 2")
        app.staticTexts["GuidePageGuideTitle"].swipeLeft()
        snapshot("Guide 3")
        app.buttons.firstMatch.tap()
    }
}
