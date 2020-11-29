//
//  MainDependency.swift
//  RxSwiftDemo
//
//  Created by 999-503 on 2020/10/25.
//  Copyright © 2020 SoLaMi Smile. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Dependency (for MainViewController)
extension MainViewController
{
    struct Dependency
    {
        /* example: 
        var viewType: MainViewType
        var modules: AppDependency.Modules
        var isCallFromSplash: Bool = false
        */
    }

    struct InnerDependency
    {
        //var viewType: MainViewType
        //var contentView: MainViewProtocol
        var viewModel: MainViewModel
    }
    
    static func makeVC(dependency: MainViewController.Dependency) -> MainViewController {
        
        func makeViewModel(viewController: MainViewController) -> MainViewModel?
        {
            return MainViewModel(
                inputs: MainViewModel.Inputs(
                    cellTappedSignal: viewController.cellTappedSignal)
            )
        }
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainViewController

        // inject
        guard let viewModel = makeViewModel(viewController: viewController) else {
            return viewController
        }

        viewController.inject(by: InnerDependency(
            /*
                viewType: dependency.viewType,
                contentView: contentView,
            */
                viewModel: viewModel
            )
        )
        
        return viewController
    }

    static func make(dependency: MainViewController.Dependency) -> UINavigationController
    {

        let viewController: MainViewController = makeVC(dependency: dependency)

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen

        return navigationController
    }
}
