//
// Created by Adam Haafiz on 2019-07-28.
// Copyright (c) 2019 Adam Haafiz. All rights reserved.
//

public enum SuitType: CaseIterable {
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