//
//  ViewModeling.swift
//  RxSwiftDemo
//
//  Created by 999-503 on 2020/10/19.
//  Copyright © 2020 SoLaMi Smile. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ViewModeling
{
    associatedtype Inputs  // NOTE: VC, ViewからViewModelへの入力を定義 (VM内利用モジュールも含む)
    associatedtype Outputs // NOTE: ViewModelからVC, Viewへの出力を定義
    init(inputs: Inputs)
    var outputs: Outputs! { get }
}
