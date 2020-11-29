//
//  MainViewModel.swift
//  RxSwiftDemo
//
//  Created by 999-503 on 2020/10/25.
//  Copyright © 2020 SoLaMi Smile. All rights reserved.
//

import RxSwift
import RxCocoa

final class MainViewModel: ViewModeling
{
    typealias Inputs = MainViewModelInputs
    typealias Outputs = MainViewModelOutputs
    var outputs: Outputs!

    private let disposeBag = DisposeBag()
    private let tableViewRelay = BehaviorRelay<MainModel>(value: MainModel.getInitialModel())

    init(inputs: Inputs)
    {
        // MARK: - configure Outputs
        outputs = Outputs(
            tableViewDriver: tableViewDriver
        )
    }
}

// MARK: - define Inputs, Outputs
extension MainViewModel
{
    struct MainViewModelInputs
    {
        let cellTappedSignal: Signal<MainRowModel>
    }

    struct MainViewModelOutputs
    {
        let tableViewDriver: Driver<MainModel>
    }
}

// MARK: - lazy bind (binding VC behaivor)
extension MainViewModel
{
    // 後からMainViewModelに注入したいインプット
    enum LazyBindInputType
    {
    }

    func lazyBind(with types: [LazyBindInputType])
    {
    }
}

// MARK: - private (for Outputs)
extension MainViewModel
{
    private var tableViewDriver: Driver<MainModel>
    {
        return tableViewRelay.asDriver()
    }
}
