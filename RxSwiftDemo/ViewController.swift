//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by USER on 2020/01/25.
//  Copyright © 2020 SoLaMi Smile. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.viewModel = ViewModel()
            //Subjectを購読
        self.viewModel.helloWorldObservable.subscribe({[weak self] value in
                print("value = \(value)")
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.updateItem()
    }


}

