//
// Created by Adam Haafiz on 2019-07-28.
// Copyright (c) 2019 Adam Haafiz. All rights reserved.
//

public struct Game {
    public var cards: [Card]
    public var gameOverClosure: ((Game) -> Void)?

    public init() {
        cards = []
    }

    mutating public func build() {
        var newCards: [Card] = []

        SuitType.allCases.forEach { suit in
            ActionType.allCases.forEach { action in
                newCards.append(Card(suitType: suit, rank: action.rawValue, header: "foo", body: "bar"))
            }
        }

        cards = newCards.shuffled()
    }

    mutating public func remove(card: Card) {
        if let index = cards.firstIndex(where: { $0 == card }) {
            cards.remove(at: index)
            checkWinningCondition()
        }
    }

    public func numberOfKings() -> Int {
        return cards.reduce(0) { (result: Int, card: Card) -> Int in
            card.rank == "K" ? result + 1 : result
        }
    }

    private func checkWinningCondition() {
        if numberOfKings() == 0 {
            gameOverClosure?(self)
        }
    }
}