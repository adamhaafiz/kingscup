//
//  Data+R.swift
//  KingsCup
//
//  Created by Adam Haafiz on 18/08/2019.
//  Copyright © 2019 Adam Haafiz. All rights reserved.
//

import KingsCupData

extension ActionType {
    var title: String {
        switch self {

        case .waterfall:
            return R.string.localizable.header_waterfall()
        case .you:
            return R.string.localizable.header_you()
        case .me:
            return R.string.localizable.header_me()
        case .thumbMaster:
            return R.string.localizable.header_thumb_master()
        case .dudes:
            return R.string.localizable.header_dudes()
        case .chicks:
            return R.string.localizable.header_chicks()
        case .heaven:
            return R.string.localizable.header_heaven()
        case .mate:
            return R.string.localizable.header_mate()
        case .snakeEyes:
            return R.string.localizable.header_snake_eyes()
        case .category:
            return R.string.localizable.header_category()
        case .jack:
            return R.string.localizable.header_jack()
        case .questions:
            return R.string.localizable.header_questions()
        case .king:
            return R.string.localizable.header_king()
        }
    }

    var body: String {
        switch self {

        case .waterfall:
            return R.string.localizable.body_waterfall()
        case .you:
            return R.string.localizable.body_you()
        case .me:
            return R.string.localizable.body_me()
        case .thumbMaster:
            return R.string.localizable.body_thumb_master()
        case .dudes:
            return R.string.localizable.body_dudes()
        case .chicks:
            return R.string.localizable.body_chicks()
        case .heaven:
            return R.string.localizable.body_heaven()
        case .mate:
            return R.string.localizable.body_mate()
        case .snakeEyes:
            return R.string.localizable.body_snake_eyes()
        case .category:
            return R.string.localizable.body_category()
        case .jack:
            return R.string.localizable.body_jack()
        case .questions:
            return R.string.localizable.body_questions()
        case .king:
            return R.string.localizable.body_king()
        }
    }
}
