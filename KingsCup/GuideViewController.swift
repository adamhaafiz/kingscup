//
//  GuideViewController
//  KingsCup
//
//  Created by Adam Haafiz on 03/08/2019.
//  Copyright © 2019 Adam Haafiz. All rights reserved.
//

import UIKit

class GuideViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    var pages: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        dataSource = self

        let pageOne = storyboard!.instantiateViewController(withIdentifier: "GuideOne")
        let pageTwo = storyboard!.instantiateViewController(withIdentifier: "GuideTwo")
        let pageThree = storyboard!.instantiateViewController(withIdentifier: "GuideThree")

        setViewControllers([pageOne], direction: .forward, animated: true)
        pages = [pageOne, pageTwo, pageThree]

        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ic_arrow_back"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 32
        button.layer.masksToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        button.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
        view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            button.widthAnchor.constraint(equalToConstant: 66),
            button.heightAnchor.constraint(equalToConstant: 66),
        ])
    }

    @objc func dismiss(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        let indexBefore = pages.index(before: index)

        return pages[indexBefore]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < (pages.count - 1) else {
            return nil
        }
        let indexAfter = pages.index(after: index)

        return pages[indexAfter]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
