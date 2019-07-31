//
//  KingsCupDataTests.swift
//  KingsCupDataTests
//
//  Created by Adam Haafiz on 28/07/2019.
//  Copyright © 2019 Adam Haafiz. All rights reserved.
//

import XCTest
@testable import KingsCupData

class CardTests: XCTestCase {
    func testCard_shouldInit() {
        let sut = Card(suitType: .hearts, actionType: .king)

        XCTAssert(sut.suitType == .hearts)
        XCTAssert(sut.rank == "1")
        XCTAssert(sut.actionType == .king)
    }

    func testCard_givenKingRank_shouldReturnIsKing() {
        let sut = Card(suitType: .clubs, actionType: .king)

        XCTAssert(sut.isKing)
    }

    func testCard_givenJackRank_shouldReturnIsNotKing() {
        let sut = Card(suitType: .clubs, actionType: .jack)

        XCTAssertFakse(sut.isKing)
    }
}
