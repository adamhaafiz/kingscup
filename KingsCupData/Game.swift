//
// Created by Adam Haafiz on 2019-07-28.
// Copyright (c) 2019 Adam Haafiz. All rights reserved.
//

public struct Game {
    public var cards: [Card]

    public init(cards: [Card]) {
        self.cards = cards
    }

    mutating func build() {
        var newCards: [Card] = []

        SuitType.allCases.forEach { suit in
            ActionType.allCases.forEach { action in
                newCards.append(Card(suitType: suit, rank: action.rawValue, header: "foo", body: "bar"))
            }
        }

        cards = newCards.shuffled()
    }
}