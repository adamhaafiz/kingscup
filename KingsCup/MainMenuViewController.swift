//
//  MainMenuViewController.swift
//  KingsCup
//
//  Created by Adam Haafiz on 10/08/2019.
//  Copyright © 2019 Adam Haafiz. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = R.string.localizable.app_name().uppercased()
        }
    }
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.setTitle(R.string.localizable.board_title_lets_begin().uppercased(), for: .normal)
            startButton.titleLabel?.adjustsFontSizeToFitWidth = true
            startButton.accessibilityIdentifier = "MainMenuStartButton"
        }
    }
    @IBOutlet weak var guideButton: UIButton! {
        didSet {
            guideButton.setTitle(R.string.localizable.preference_title_quick_guide().uppercased(), for: .normal)
            guideButton.titleLabel?.adjustsFontSizeToFitWidth = true
            guideButton.accessibilityIdentifier = "MainMenuGuideButton"
        }
    }
}
