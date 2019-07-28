//
// Created by Adam Haafiz on 2019-07-28.
// Copyright (c) 2019 Adam Haafiz. All rights reserved.
//

public struct Game {
    public let cards: [Card]

    public init(cards: [Card]) {
        self.cards = cards
    }

    mutating func shuffle() {}
}