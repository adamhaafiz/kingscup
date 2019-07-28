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
    func createMockCard() -> Card {
        return Card(suitType: .clubs, rank: "1", header: "foo", body: "bar")
    }

    func testGame_shouldInit() {
        let sut = Game(cards: [createMockCard()])

        XCTAssert(sut.cards.count == 1)
    }

}
