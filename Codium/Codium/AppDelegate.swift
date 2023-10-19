//
//  AppDelegate.swift
//  Codium
//
//  Created by Gilles Zwijsen on 18/10/2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Create a UIWindow instance
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Create your root view controller
        let rootViewController = MainTabBarController()
        
        // Create a UINavigationController and set its root view controller
        let navigationController = UINavigationController(rootViewController: rootViewController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
