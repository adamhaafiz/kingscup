//
//  ViewController.swift
//  KingsCup
//
//  Created by Adam Haafiz on 28/07/2019.
//  Copyright © 2019 Adam Haafiz. All rights reserved.
//

import UIKit
import KingsCupData
import Lottie

class ViewController: UIViewController {
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var cupImageView: UIImageView!
    @IBOutlet weak var crownsStackView: UIStackView!
    @IBOutlet weak var statusLabel: UILabel!

    var game: Game!
    var animationUpdate: (() -> Void)?

    let cardCellIdentifier = "CardCell"
    let taunts = ["Seriously", "Coming Up", "Just One More", "This Is It", "Don't Think", "Drink Me", "Faster Mate", "You Sure?", "Alright Buddy?", "Come On"]

    override func viewDidLoad() {
        super.viewDidLoad()

        game = Game()
        game.build()
        game.gameOverClosure = { [weak self] game in
            debugPrint("Game Over! \(game.numberOfKings()) \(game.cards.count)")

            guard let self = self else {
                return
            }

            let animationView = AnimationView(name: "confetti")
            self.view.addSubview(animationView)
            animationView.isUserInteractionEnabled = false
            animationView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                animationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                animationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                animationView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
                animationView.widthAnchor.constraint(equalTo: self.view.widthAnchor)])
            animationView.play()
        }
        game.kingsNumberChangedClosure = { [weak self] kingsLeft in
            guard let self = self else {
                return
            }

            let feedbackGenerator = UIImpactFeedbackGenerator()
            feedbackGenerator.impactOccurred()

            let crownImageView = self.crownsStackView.arrangedSubviews[kingsLeft] as? UIImageView
            UIView.animate(withDuration: 0.3, animations: {
                crownImageView?.alpha = 0
            })

            UIView.transition(with: self.cupImageView, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                self.cupImageView.image = UIImage(named: "cup_volume_\(kingsLeft)")
            }, completion: nil)
        }

        cardCollectionView.collectionViewLayout = CardFlowLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let animationUpdate = animationUpdate {
            animationUpdate()
            self.animationUpdate = nil
        }
    }

    @IBAction func unwindToHomeScreen(_ unwindSegue: UIStoryboardSegue) {
        guard let cardViewController = unwindSegue.source as? CardViewController,
              let cardToBeRemoved = cardViewController.card else {
            return
        }

        animationUpdate = { [weak self] in
            let index = self?.game.cards.firstIndex(of: cardToBeRemoved)!
            self?.game.remove(card: cardToBeRemoved)
            self?.cardCollectionView.performBatchUpdates({
                self?.cardCollectionView.deleteItems(at: [IndexPath(item: index!, section: 0)])
            }, completion: nil)

            self?.statusLabel.text = self?.game.numberOfKings() ?? 0 > 0 ? self?.taunts.randomElement()?
                    .uppercased() : "Drink It Up!".uppercased()
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.cards.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardCell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCellIdentifier,
                for: indexPath) as! CardCell

        #if DEBUG
        cell.debugLabel.text = "\(game.cards[indexPath.item].rank) \(game.cards[indexPath.item].suitType.rawValue)"
        #endif

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cardViewController = storyboard?.instantiateViewController(withIdentifier: "CardViewController") as? CardViewController else {
            return
        }

        _ = cardViewController.view

        cardViewController.card = game.cards[indexPath.item]
        present(cardViewController, animated: true)
    }
}

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

