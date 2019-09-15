//
// Created by Adam Haafiz on 2019-07-28.
// Copyright (c) 2019 Adam Haafiz. All rights reserved.
//

public struct GameEngine {
    public var cards: [Card] = []
    public var gameOverClosure: ((GameEngine) -> Void)?
    public var kingsNumberChangedClosure: ((Int) -> Void)?

    public init() {
        build()
    }

    mutating public func build() {
        var newCards: [Card] = []

        SuitType.allCases.forEach { suit in
            ActionType.allCases.forEach { action in
                newCards.append(Card(suitType: suit, actionType: action))
            }
        }

        if ProcessInfo.processInfo.arguments.contains("UITests") {
            cards = newCards
        } else if ProcessInfo.processInfo.arguments.contains("Screenshots") {
            cards = newCards.sorted(by: { (lhs, rhs) -> Bool in
                lhs.isKing
            })
        } else {
            cards = newCards.shuffled()
        }
    }

    mutating public func remove(card: Card) {
        if let index = cards.firstIndex(where: { $0 == card }) {
            let removedCard = cards.remove(at: index)

            if removedCard.isKing {
                kingsNumberChangedClosure?(numberOfKings())
            }

            checkWinningCondition()
        }
    }

    public func numberOfKings() -> Int {
        return cards.reduce(0) { (result: Int, card: Card) -> Int in
            card.isKing ? result + 1 : result
        }
    }

    private mutating func checkWinningCondition() {
        if numberOfKings() == 0 {
            gameOverClosure?(self)
            gameOverClosure = nil
        }
    }
}
