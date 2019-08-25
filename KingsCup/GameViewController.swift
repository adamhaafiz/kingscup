//
//  GameViewController.swift
//  KingsCup
//
//  Created by Adam Haafiz on 28/07/2019.
//  Copyright © 2019 Adam Haafiz. All rights reserved.
//

import UIKit
import KingsCupData
import Lottie
import AVFoundation

class GameViewController: UIViewController {
    @IBOutlet weak var cardCollectionView: UICollectionView! {
        didSet {
            cardCollectionView.collectionViewLayout = CardFlowLayout()
        }
    }
    @IBOutlet weak var cupImageView: UIImageView!
    @IBOutlet weak var crownsStackView: UIStackView!
    @IBOutlet weak var statusLabel: UILabel! {
        didSet {
            statusLabel.text = R.string.localizable.board_title_lets_begin().uppercased()
        }
    }

    var game: Game!
    var animationUpdate: (() -> Void)?

    var flipSoundEngine: AVAudioPlayer?
    var whooshSoundEngine: AVAudioPlayer?
    var gameOverSoundEngine: AVAudioPlayer?
    var kingSoundEngine: AVAudioPlayer?

    let taunts = [R.string.localizable.taunt_one(),
                  R.string.localizable.taunt_two(),
                  R.string.localizable.taunt_three(),
                  R.string.localizable.taunt_four(),
                  R.string.localizable.taunt_five(),
                  R.string.localizable.taunt_six(),
                  R.string.localizable.taunt_seven(),
                  R.string.localizable.taunt_eight(),
                  R.string.localizable.taunt_nine(),
                  R.string.localizable.taunt_ten()]

    override func viewDidLoad() {
        super.viewDidLoad()

        if kingSoundEngine == nil {
            let fileURL = R.file.kingWav()!
            kingSoundEngine = try! AVAudioPlayer(contentsOf: fileURL)
        }

        kingSoundEngine!.play()

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

            if self.gameOverSoundEngine == nil {
                let fileURL = R.file.game_overWav()!
                self.gameOverSoundEngine = try! AVAudioPlayer(contentsOf: fileURL)
            }

            self.gameOverSoundEngine!.play()
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

        if self.whooshSoundEngine == nil {
            let fileURL = R.file.whooshWav()!
            self.whooshSoundEngine = try! AVAudioPlayer(contentsOf: fileURL)
        }

        self.whooshSoundEngine!.play()

        animationUpdate = { [weak self] in
            let index = self?.game.cards.firstIndex(of: cardToBeRemoved)!
            self?.game.remove(card: cardToBeRemoved)
            self?.cardCollectionView.performBatchUpdates({
                self?.cardCollectionView.deleteItems(at: [IndexPath(item: index!, section: 0)])
            }, completion: nil)

            self?.statusLabel.text = self?.game.numberOfKings() ?? 0 > 0 ? self?.taunts.randomElement()?
                    .uppercased() : R.string.localizable.game_over_body().uppercased()
        }
    }

    @IBAction func showPauseSheet(_ sender: UIView) {
        let actionSheet = UIAlertController(title: nil, message: R.string.localizable.dialog_pause_title(), preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: R.string.localizable.dialog_pause_button_quit(), style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        actionSheet.addAction(UIAlertAction(title: R.string.localizable.dialog_pause_button_resume(), style: .cancel))
        actionSheet.popoverPresentationController?.sourceView = sender

        present(actionSheet, animated: true)
    }
}

extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.cards.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.cardCell,
                for: indexPath)!

        #if DEBUG
        cell.debugLabel.text = "\(game.cards[indexPath.item].rank) \(game.cards[indexPath.item].suitType.rawValue)"

        if ProcessInfo.processInfo.arguments.contains("UITests") {
            cell.debugLabel.alpha = 0.001
        }
        #endif

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cardViewController = R.storyboard.main.cardViewController() else {
            return
        }

        _ = cardViewController.view

        cardViewController.card = game.cards[indexPath.item]

        if flipSoundEngine == nil {
            let fileURL = R.file.flipWav()!
            flipSoundEngine = try! AVAudioPlayer(contentsOf: fileURL)
        }

        flipSoundEngine!.play()

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

