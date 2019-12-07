//
//  CardFlowLayout.swift
//  KingsCup
//
//  Created by Adam Haafiz on 07/12/2019.
//  Copyright © 2019 Adam Haafiz. All rights reserved.
//

import UIKit

class CardFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()

        scrollDirection = .horizontal

        let screenHeight = UIScreen.main.bounds.height
        let cellHeight = screenHeight / 3
        let cellWidth = cellHeight * (9.0 / 16.0)

        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.sectionInset = UIEdgeInsets(top: 0.0,
                left: self.minimumInteritemSpacing,
                bottom: 0.0,
                right: self.minimumInteritemSpacing)
    }
}
