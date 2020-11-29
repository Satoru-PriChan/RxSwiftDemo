//
//  AppDelegate.swift
//  RxSwiftDemo
//
//  Created by USER on 2020/01/25.
//  Copyright © 2020 SoLaMi Smile. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow()
        let dependency = MainViewController.Dependency()
        let vc = MainViewController.make(dependency: dependency)
            
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

