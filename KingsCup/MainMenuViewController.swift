//
//  MainMenuViewController.swift
//  KingsCup
//
//  Created by Adam Haafiz on 10/08/2019.
//  Copyright © 2019 Adam Haafiz. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var guideButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = R.string.localizable.board_title_lets_begin()
        startButton.setTitle("Start".uppercased(), for: .normal)
        guideButton.setTitle("Guide".uppercased(), for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
