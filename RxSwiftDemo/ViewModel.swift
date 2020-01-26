//
//  ViewModel.swift
//  RxSwiftDemo
//
//  Created by USER on 2020/01/26.
//  Copyright © 2020 SoLaMi Smile. All rights reserved.
//

import Foundation
import RxSwift

class ViewModel {
    
    private let helloWorldSubject = PublishSubject<String>()
    
    var helloWorldObservable: Observable<String> {
        //Subjectを定義
        return helloWorldSubject.asObservable()
    }
    
    func updateItem() {
        self.helloWorldSubject.onNext("Hello World!")
        self.helloWorldSubject.onNext("Hello World!!")
        self.helloWorldSubject.onNext("Hello World!!!")
        self.helloWorldSubject.onCompleted()
    }
    
    
}
