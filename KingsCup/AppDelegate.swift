//
//  AppDelegate.swift
//  KingsCup
//
//  Created by Adam Haafiz on 28/07/2019.
//  Copyright © 2019 Adam Haafiz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear

        if ProcessInfo.processInfo.arguments.contains("UITests") {
            UIApplication.shared.keyWindow?.layer.speed = Float.greatestFiniteMagnitude
        } else if ProcessInfo.processInfo.arguments.contains("Screenshots") {
            UIView.setAnimationsEnabled(false)
        }

        return true
    }
}

