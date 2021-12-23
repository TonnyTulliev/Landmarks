//
//  AppDelegate.swift
//  LandMarks
//
//  Created by Антон Скуратов on 16.12.2021.
//

import UIKit



@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainViewController = MainViewController()
        mainViewController.FetchingData()
        let navigationViewController = UINavigationController(rootViewController: mainViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()

        return true
    }


}

