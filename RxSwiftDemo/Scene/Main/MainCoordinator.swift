//
//  MainCoordinator.swift
//  RxSwiftDemo
//
//  Created by 999-503 on 2020/11/29.
//  Copyright © 2020 SoLaMi Smile. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class MainCoordinator: Coordinator {
    private let nav: UINavigationController
    private var mainViewController: MainViewController?
    private let mainViewControllerDidSelectRelay = PublishRelay<Void>()
    private var mainViewControllerDidSelectSignal: Signal<Void> {
        mainViewControllerDidSelectRelay.asSignal()
    }
    
    init(navigator: UINavigationController) {
        self.nav = navigator
    }
    
    func start() {
        let dependency = MainViewController.Dependency(mainViewControllerDidSelectSignal: mainViewControllerDidSelectSignal)
        let vc = MainViewController.makeVC(dependency: dependency)
        nav.pushViewController(vc, animated: true)
        self.mainViewController = vc
    }
}
