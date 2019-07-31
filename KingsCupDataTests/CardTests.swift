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
        let sut = Card(suitType: .hearts, rank: "1", actionType: .king)

        XCTAssert(sut.suitType == .hearts)
        XCTAssert(sut.rank == "1")
        XCTAssert(sut.actionType == .king)
    }

}
