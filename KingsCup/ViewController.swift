//
//  ViewController.swift
//  KingsCup
//
//  Created by Adam Haafiz on 28/07/2019.
//  Copyright © 2019 Adam Haafiz. All rights reserved.
//

import UIKit
import KingsCupData

class ViewController: UIViewController {
    @IBOutlet weak var cardCollectionView: UICollectionView! {
        didSet {
            cardCollectionView.backgroundColor = .red
        }
    }

    var game: Game!

    let cardCellIdentifier = "CardCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        game = Game()
        game.build()

        cardCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cardCellIdentifier)
        cardCollectionView.collectionViewLayout = CardFlowLayout()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCellIdentifier, for: indexPath)
        cell.backgroundColor = .green

        return cell
    }
}

class CardFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()

        scrollDirection = .horizontal

        let screenHeight = UIScreen.main.bounds.height
        let cellHeight = screenHeight / 2.5
        let cellWidth = cellHeight * (10.0 / 16.0)

        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.sectionInset = UIEdgeInsets(top: 0.0, left: self.minimumInteritemSpacing, bottom: 0.0, right: 0.0)
    }
}

