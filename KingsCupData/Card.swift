//
// Created by Adam Haafiz on 2019-07-28.
// Copyright (c) 2019 Adam Haafiz. All rights reserved.
//

public enum SuitType: String, CaseIterable {
    case clubs, diamonds, hearts, spades
}

public enum ActionType: String, CaseIterable {
    case waterfall = "A",
         you = "2",
         me = "3",
         thumbMaster = "4",
         dudes = "5",
         chicks = "6",
         heaven = "7",
         mate = "8",
         snakeEyes = "9",
         category = "10",
         jack = "J",
         questions = "Q",
         king = "K"
}

public struct Card: Equatable {
    public let suitType: SuitType
    public let rank: String
    public let actionType: ActionType

    public var isKing: Bool {
        return rank == ActionType.king.rawValue
    }

    public init(suitType: SuitType, actionType: ActionType) {
        self.suitType = suitType
        self.rank = actionType.rawValue
        self.actionType = actionType
    }
}
