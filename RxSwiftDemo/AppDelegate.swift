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
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow()
        let appCoordinator = AppCoordinator(window: window!)
        
        appCoordinator.start()
        self.appCoordinator = appCoordinator
        return true
    }
}

