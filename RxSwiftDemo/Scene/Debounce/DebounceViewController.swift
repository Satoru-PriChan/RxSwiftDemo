//
//  DebounceViewController.swift
//  RxSwiftDemo
//
//  Created by 999-503 on 2020/10/18.
//  Copyright © 2020 SoLaMi Smile. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class DebounceViewController: UIViewController
{
    @IBOutlet private weak var label: UILabel!
    
    @IBOutlet private weak var nextButton: UIButton!
    private let disposeBag = DisposeBag()

    // MARK: - Inner Injecter / DI parameters
    func inject(by inner: InnerDependency)
    {
        /*
        viewType = inner.viewType
        contentView = inner.contentView
        */
        viewModel = inner.viewModel
    }
    private var viewModel: DebounceViewModel!
    {
        didSet { bind() }
    }

    /* example: 
    private var webViewController: WebLoginViewController? = nil
    {
        didSet
        {
            guard let webViewController = webViewController else {
                return
            }

            viewModel.lazyBind(
                with: [
                    .getPermittedTarget(
                        signal: webViewController.getPermittedTargetObservable()
                            .asSignal(onErrorJustReturn: nil)
                    ),
                    .dismissAuthCodeWebview(
                        signal: webViewController.dismissObservable()
                            .asSignal(onErrorJustReturn: nil)
                    ),
                    .showCompleteUnitingAppUserView(
                        signal: webViewController.completeUnitingAppUserObservable()
                            .asSignal(onErrorJustReturn: ())
                    ),
                    .recieveAuthCodeAndState(
                        signal: webViewController.recieveAuthCodeAndStateObservable()
                            .asSignal(onErrorJustReturn: nil)
                    ),
                ]
            )

            webViewController.set(permittedOutputsTarget: type(of: self))
        }
    }
    */

    // MARK: - life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
}

// MARK: - private func (binding)
extension DebounceViewController
{
    private func bind()
    {
        func navigationPush(with viewController: UIViewController)
        {
            navigationController?.pushViewController(
                viewController,
                animated: true
            )
        }

        func dismiss()
        {
            self.dismiss(animated: true)
        }

        /*
        func dismissWebViewIfNeeded()
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.webViewController?.dismiss(animated: true)
                self?.webViewController = nil
                Debug.print("😁 webviewをdismiss")
            }
        }

        func setWebview(with type: WebLoginViewController.SetWebviewType)
        {
            self.setWebview(with: type)
        }
        */

        guard let viewModel = viewModel else {
            Logger.info("Cannot get view model.")
            return
        }

        // binding VM behaivor 
        // example:
        /*
        viewModel.outputs
            .dismissDriver
            .drive(onNext: { dismiss() })
            .disposed(by: disposeBag)

        viewModel.outputs
            .openLoginWebViewDriver
            .drive(onNext: { setWebview(with: .url($0)) })
            .disposed(by: disposeBag)

        viewModel.outputs
            .guestRegisterDriver
            .drive(onNext: { navigationPush(with: $0) })
            .disposed(by: disposeBag)

        viewModel.outputs
            .doneReloadingViewControllerDriver
            .drive(onNext: { Debug.print("🤔 app tokenを入手、保存処理を実行済み / ユーザ状態に合わせ画面リロードを完了") })
            .disposed(by: disposeBag)

        viewModel.outputs
            .reloadWebViewWithNewURLDriver
            .drive(onNext: { setWebview(with: .urlRequest($0)) })
            .disposed(by: disposeBag)

        viewModel.outputs
            .dismissWebViewIfNeededDriver
            .drive(onNext: { dismissWebViewIfNeeded() })
            .disposed(by: disposeBag)
        */
    }
}

// MARK: - private func (etc)
private extension DebounceViewController
{
    /* example:
    func setContentView()
    {
        self.contentView.frame = view.bounds
        view.addSubview(self.contentView)
    }
    */
}
