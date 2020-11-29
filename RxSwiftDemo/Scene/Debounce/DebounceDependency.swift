//
//  DebounceDependency.swift
//  RxSwiftDemo
//
//  Created by 999-503 on 2020/10/18.
//  Copyright © 2020 SoLaMi Smile. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Dependency (for DebounceViewController)
extension DebounceViewController
{
    struct Dependency
    {
        /* example: 
        var viewType: DebounceViewType
        var modules: AppDependency.Modules
        var isCallFromSplash: Bool = false
        */
    }

    struct InnerDependency
    {
        //var viewType: DebounceViewType
        //var contentView: DebounceViewProtocol
        var viewModel: DebounceViewModel
    }
    
    static func makeVC(dependency: DebounceViewController.Dependency) -> DebounceViewController {
        
        func makeViewModel(viewController: DebounceViewController) -> DebounceViewModel?
        {
            return DebounceViewModel(
                inputs: DebounceViewModel.Inputs(
                    target: type(of: viewController)
                    /* example: 
                    authService: dependency.modules.authService,
                    skipButtonTap: dependency.isCallFromSplash
                            ? view.skipButton.rx.tap.asSignal()
                            : viewController.navigationItem.rightBarButtonItem?.rx.tap.asSignal(),
                    registerButtonTap: view.registerButton.rx.tap.asSignal(),
                    loginButtonTap: view.loginButton.rx.tap.asSignal(),
                    guestRegisterButtonTap: view.guestRegisterButton.rx.tap.asSignal()
                    */
                )
            )
        }
        
        let viewController = UIStoryboard(name: "Debounce", bundle: nil).instantiateViewController(withIdentifier: "DebounceViewController") as! DebounceViewController

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

    static func make(dependency: DebounceViewController.Dependency) -> UINavigationController
    {

        let viewController: DebounceViewController = makeVC(dependency: dependency)

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen

        return navigationController
    }
}
