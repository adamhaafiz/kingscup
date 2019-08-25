//
// Created by Adam Haafiz on 2019-08-18.
// Copyright (c) 2019 Adam Haafiz. All rights reserved.
//

import UIKit

class GuidePageViewController: UIViewController {
    @IBOutlet weak var guideTitle: UILabel! {
        didSet {
            guideTitle.text = R.string.localizable.preference_title_quick_guide()
            guideTitle.accessibilityIdentifier = "GuidePageGuideTitle"
        }
    }
    @IBOutlet weak var guideBody: UILabel! {
        didSet {
            guideBody.text = bodyString
        }
    }

    private(set) var bodyString: String = ""

    func configure(body: String) {
        self.bodyString = body
    }
}
