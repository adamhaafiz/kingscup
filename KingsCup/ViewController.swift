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
        game.gameOverClosure = { game in
            debugPrint("Game Over! \(game.numberOfKings()) \(game.cards.count)")
        }

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
        cell.backgroundColor = game.cards[indexPath.item].rank == "K" ? .green : .blue

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = game.cards[indexPath.item]
        let alert = UIAlertController(title: card.rank, message: card.suitType.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true) { [weak self, weak collectionView] in
            self?.game.remove(card: card)
            collectionView?.reloadData()
        }
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

