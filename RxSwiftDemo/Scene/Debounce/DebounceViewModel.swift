//
//  DebounceViewModel.swift
//  RxSwiftDemo
//
//  Created by 999-503 on 2020/10/18.
//  Copyright © 2020 SoLaMi Smile. All rights reserved.
//

import RxSwift
import RxCocoa

final class DebounceViewModel: ViewModeling
{
    typealias Inputs = DebounceViewModelInputs
    typealias Outputs = DebounceViewModelOutputs
    var outputs: Outputs!

    private let disposeBag = DisposeBag()
    private let target: UIViewController.Type
     /* example:
    private let tappedSkipButtonRelay = PublishRelay<Void>()
    private let tappedRegisterButtonRelay = PublishRelay<Void>()
    private let tappedLoginButtonRelay = PublishRelay<Void>()
    private let tappedGuestRegisterButtonRelay = PublishRelay<Void>()
    private let getPermittedTargetRelay = BehaviorRelay<UIViewController.Type?>(value: nil)
    private let dismissAuthCodeWebviewRelay = PublishRelay<UIViewController.Type?>()
    private let recieveAuthCodeAndStateRelay = PublishRelay<RecievedWebData?>()
    private let showCompleteUnitingAppUserViewRelay = PublishRelay<Void>()
    */

    init(inputs: Inputs)
    {
        target = inputs.target
        
        // MARK: - bind (binding VC behaivor)
        /* example:
        _ = inputs.skipButtonTap?
            .debug("skipButtonTap")
            .emit(to: tappedSkipButtonRelay)
            .disposed(by: disposeBag)

        _ = inputs.registerButtonTap?
            .debug("registerButtonTap")
            .emit(to: tappedRegisterButtonRelay)
            .disposed(by: disposeBag)

        _ = inputs.loginButtonTap?
            .debug("loginButtonTap")
            .emit(to: tappedLoginButtonRelay)
            .disposed(by: disposeBag)

        _ = inputs.guestRegisterButtonTap?
            .debug("guestRegisterButtonTap")
            .emit(to: tappedGuestRegisterButtonRelay)
            .disposed(by: disposeBag)
        */

        // MARK: - configure Outputs
        outputs = Outputs(
            /*
            dismissDriver: dismissDriver,
            dismissWebViewIfNeededDriver: dismissWebViewIfNeededDriver,
            openLoginWebViewDriver: openLoginWebViewDriver,
            reloadWebViewWithNewURLDriver: reloadWebViewWithNewURLDriver,
            guestRegisterDriver: guestRegisterDriver,
            doneReloadingViewControllerDriver: doneReloadingViewControllerDriver
            */
        )
    }
}

// MARK: - define Inputs, Outputs
extension DebounceViewModel
{
    struct DebounceViewModelInputs
    {
        let target: UIViewController.Type
        /* example:
        let authService: AuthServiceProtocol
        let skipButtonTap: RxCocoa.Signal<Void>?
        let registerButtonTap: RxCocoa.Signal<Void>?
        let loginButtonTap: RxCocoa.Signal<Void>?
        let guestRegisterButtonTap: RxCocoa.Signal<Void>?
        */
    }

    struct DebounceViewModelOutputs
    {
        /* example:
        let dismissDriver: Driver<Void>
        let dismissWebViewIfNeededDriver: Driver<Void>
        let openLoginWebViewDriver: Driver<URL?>
        let reloadWebViewWithNewURLDriver: Driver<URLRequest>
        let guestRegisterDriver: Driver<TermsOfServiceViewController>
        let doneReloadingViewControllerDriver: Driver<Void>
        */
    }
}

// MARK: - lazy bind (binding VC behaivor)
extension DebounceViewModel
{
    // 後からDebounceViewModelに注入したいインプット
    enum LazyBindInputType
    {
        /* example:
        case getPermittedTarget(signal: RxCocoa.Signal<UIViewController.Type?>)
        case showCompleteUnitingAppUserView(signal: RxCocoa.Signal<Void>)
        case dismissAuthCodeWebview(signal: RxCocoa.Signal<UIViewController.Type?>)
        case recieveAuthCodeAndState(signal: RxCocoa.Signal<RecievedWebData?>)
        */
    }

    func lazyBind(with types: [LazyBindInputType])
    {
        /* example: 
        types.forEach {
            switch $0 {
            case .getPermittedTarget(signal: let signal):
                _ = signal
                .debug("[lazy bind] getPermittedTargetRelay")
                .emit(to: getPermittedTargetRelay)
                .disposed(by: disposeBag)
            case .showCompleteUnitingAppUserView(let signal):
                _ = signal
                    .debug("[lazy bind] showCompleteUnitingAppUserView")
                    .emit(to: showCompleteUnitingAppUserViewRelay)
                    .disposed(by: disposeBag)
            case .dismissAuthCodeWebview(let signal):
                _ = signal
                    .debug("[lazy bind] dismissAuthCodeWebview")
                    .emit(to: dismissAuthCodeWebviewRelay)
                    .disposed(by: disposeBag)
            case .recieveAuthCodeAndState(let signal):
                _ = signal
                    .debug("[lazy bind] recieveAuthCodeAndState")
                    .emit(to: recieveAuthCodeAndStateRelay)
                    .disposed(by: disposeBag)
            }
        }
        */
    }
}

// MARK: - private (for Outputs)
extension DebounceViewModel
{
    /* example:
    private var dismissDriver: Driver<Void>
    {
        return tappedSkipButtonRelay
            .asDriver(onErrorJustReturn: ())
    }

    private var dismissWebViewIfNeededDriver: Driver<Void>
    {
        return recieveAuthCodeAndStateRelay
            .asDriver(onErrorJustReturn: nil)
            .filter { $0 != nil }
            .map { _ in () }
    }

    private var openLoginWebViewDriver: Driver<URL?>
    {
        return Observable
            .of(
                tappedLoginButtonRelay,
                tappedRegisterButtonRelay,
                showCompleteUnitingAppUserViewRelay
            )
            .merge()
            .asDriver(onErrorJustReturn: ())
            .flatMap { [unowned self] _ in self.authService.drivers.openLoginWebViewDriver }
    }

    private var reloadWebViewWithNewURLDriver: Driver<URLRequest>
    {
        return authService.drivers.reloadWebviewWithNewURLDriver
            .filter { [unowned self] _ in
                // NOTE: 認証作業対象のVMのみ連携を許可
                self.authService.isPermittedSubscribe(
                    viewType: self.target,
                    permitted: self.getPermittedTargetRelay.value
                )
            }
    }
    
    private var guestRegisterDriver: Driver<TermsOfServiceViewController>
    {
        var serviceCenterList : [SCListRowModel]
        {
            var list: [SCListRowModel?] = []
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let nowSCRow = SCListRowModel(
                name: appDelegate.nowScMaster?.scname,
                code: appDelegate.nowScMaster?.sccode
            )

            list.append(nowSCRow) // 「今いる」施設追加
            list.append(
                contentsOf: InAppDataManager.FavoriteScMasters
                    .compactMap { SCListRowModel(name: $0.scname, code: $0.sccode) }   // 「お気に入り施設」追加
                    .filter { $0.name != nowSCRow?.name && $0.code != nowSCRow?.code } // 「今いる施設」と重複した場合は除外
            )
            list.append(SCListRowModel(name: "&mall（オンラインストア)", code: "0315"))    // 「&mall」追加

            return list.filter { $0 != nil } as! [SCListRowModel]
        }

        return tappedGuestRegisterButtonRelay
            .map {
                TermsOfServiceViewController.make(
                    dependency: TermsOfServiceViewController.Dependency(
                        modules: AppDelegate.appDependency.modules,
                        serviceList: serviceCenterList
                    )
                )
            }
            .asDriver(onErrorJustReturn: TermsOfServiceViewController())
    }

    /*

     - code / stateを元に、ログインAPIをリクエスト
     - レスポンスより、app tokenを取得
     - VCを更新させる

     */
    private var doneReloadingViewControllerDriver: Driver<Void>
    {
        return Observable
            .zip(
                recieveAuthCodeAndStateRelay,
                dismissAuthCodeWebviewRelay
            )
            .filter { [unowned self] in
                // NOTE: 認証作業対象のVMのみ連携を許可
                self.authService.isPermittedSubscribe(
                    viewType: self.target,
                    permitted: self.getPermittedTargetRelay.value,
                    dismissed: $0.1
                )
            }
            .debug("☎️ [ログインAPI] DebounceViewModelからリクエスト")
            .flatMap { [unowned self] in
                return self.authService
                    .loginSingle(recievedWebData: $0.0)
            }
            .asDriver(onErrorJustReturn: AppTokenMaterial.empty)
            .filter { $0.result != nil }
            .debug("☎️ [ログインAPI] リクエスト結果")
            .map { [unowned self] in self.authService.regist($0.result!.token) } // NOTE: App tokenを保存
            .do(onNext: {
                // NOTE: APIをたたかずユーザーステータス変更（ログイン）
                UserStatusHandler.shared.forceUpdate(by: .login)
            })
    }
    */
}
