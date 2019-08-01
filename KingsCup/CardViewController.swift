//
//  CardViewController.swift
//  KingsCup
//
//  Created by Adam Haafiz on 29/07/2019.
//  Copyright © 2019 Adam Haafiz. All rights reserved.
//

import UIKit
import KingsCupData

class CardViewController: UIViewController {
    @IBOutlet var suitLabels: [UILabel]!
    @IBOutlet var suitImageViews: [UIImageView]!
    @IBOutlet weak var actionTypeTitleLabel: UILabel!
    @IBOutlet weak var actionTypeBodyLabel: UILabel!
    @IBOutlet weak var tintedSuitImageView: UIImageView!

    var card: Card? {
        didSet {
            suitLabels.forEach { $0.text = card?.rank }
            suitImageViews.forEach { $0.image = UIImage(named: card?.suitType.rawValue ?? "spades" )  }
            actionTypeTitleLabel.text = card?.actionType.title.uppercased()
            actionTypeBodyLabel.text = card?.actionType.body

            tintedSuitImageView.setImageColor(color: UIColor(named: "PrimaryColor") ?? .black)
        }
    }
}

// https://stackoverflow.com/a/36591030/1952466
extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
