//
//  KingsCupDataTests.swift
//  KingsCupDataTests
//
//  Created by Adam Haafiz on 28/07/2019.
//  Copyright © 2019 Adam Haafiz. All rights reserved.
//

import XCTest
@testable import KingsCupData

class GameTests: XCTestCase {
    var sut: GameEngine = GameEngine()

    override func setUp() {
        super.setUp()
    }

    func testGame_build_shouldInitFullDeck() {
        XCTAssert(sut.cards.count == 52)
    }

    func testGame_build_shouldInitDeckWithFourKings() {
        XCTAssert(sut.numberOfKings() == 4)
    }

    func testGame_remove_shouldReduceCardCount() {
        let nonKingCard = sut.cards.first { $0.rank != "K" }!

        let countBeforeRemoval = sut.cards.count
        sut.remove(card: nonKingCard)

        XCTAssert(sut.cards.count == countBeforeRemoval - 1)
    }

    func testGame_kingRemoval_shouldReduceKingCount() {
        let kingCard = sut.cards.first { $0.rank == "K" }!

        let countBeforeRemoval = sut.numberOfKings()
        sut.remove(card: kingCard)

        XCTAssert(sut.numberOfKings() == countBeforeRemoval - 1)
    }

    func testGame_whenThereAreNoKings_winningConditionShouldTrigger() {
        let expectation = self.expectation(description: "Winning condition should trigger")

        sut.gameOverClosure = { game in
            XCTAssert(game.numberOfKings() == 0)
            expectation.fulfill()
        }

        while sut.numberOfKings() > 0 {
            let kingCard = sut.cards.first { $0.rank == "K" }!
            sut.remove(card: kingCard)
        }

        waitForExpectations(timeout: 1.0)
    }
}
