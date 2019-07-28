//
// Created by Adam Haafiz on 2019-07-28.
// Copyright (c) 2019 Adam Haafiz. All rights reserved.
//

public enum SuitType {
    case clubs, diamonds, hearts, spades
}

public struct Card {
    public let suitType: SuitType
    public let rank: String
    public let header: String
    public let body: String

    public init(suitType: SuitType, rank: String, header: String, body: String) {
        self.suitType = suitType
        self.rank = rank
        self.header = header
        self.body = body
    }
}