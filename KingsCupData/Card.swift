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

    public var title: String {
        switch self {

        case .waterfall:
            return "Waterfall"
        case .you:
            return "You"
        case .me:
            return "Me"
        case .thumbMaster:
            return "Thumb Master"
        case .dudes:
            return "Dudes"
        case .chicks:
            return "Chicks"
        case .heaven:
            return "Heaven"
        case .mate:
            return "Mate"
        case .snakeEyes:
            return "Snake Eyes"
        case .category:
            return "Category"
        case .jack:
            return "Jack"
        case .questions:
            return "Questions"
        case .king:
            return "King"
        }
    }

    public var body: String {
        switch self {

        case .waterfall:
            return "Everyone starts drinking until the person who drew the card has stopped."
        case .you:
            return "Choose a mate\nAnd drink together!"
        case .me:
            return "Only you. Drink!"
        case .thumbMaster:
            return "Place your thumb\non the table.\nLast to do so, drinks!"
        case .dudes:
            return "All guys drink!"
        case .chicks:
            return "All ladies drink!"
        case .heaven:
            return "Everyone reach for the sky with both hands.\nLast player drinks!"
        case .mate:
            return "Choose a partner and drink whenever that player drinks!"
        case .snakeEyes:
            return "Nobody can make\neye contact with you.\nIf caught, drink!"
        case .category:
            return "Choose a category.\nSay something that fits until whoever can't think of any, drink!"
        case .jack:
            return "Complete the sentence,\n \"Never have I ever..\" \nAnyone who has, drink!"
        case .questions:
            return "Ask a player a question.\nThey must respond with another question to the next person.\n\nFirst to fail, drink!"
        case .king:
            return "Set a new rule.\nFill the King's Cup!"
        }
    }
}

public struct Card: Equatable {
    public let suitType: SuitType
    public let rank: String
    public let actionType: ActionType

    public init(suitType: SuitType, rank: String, actionType: ActionType) {
        self.suitType = suitType
        self.rank = rank
        self.actionType = actionType
    }
}
