//
//  AppCoordinator.swift
//  RxSwiftDemo
//
//  Created by 999-503 on 2020/11/29.
//  Copyright © 2020 SoLaMi Smile. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var mainCoordinator: MainCoordinator
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = .init()
        
        self.mainCoordinator = MainCoordinator(navigator: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        mainCoordinator.start()
        window.makeKeyAndVisible()
    }
}
