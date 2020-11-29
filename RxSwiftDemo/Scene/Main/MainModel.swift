//
//  MainModel.swift
//  RxSwiftDemo
//
//  Created by 999-503 on 2020/10/25.
//  Copyright © 2020 SoLaMi Smile. All rights reserved.
//

import RxDataSources

struct MainModel
{
    var sections: [MainSectionModel]
}

struct MainSectionModel {
    let title: String
    var items: [MainRowModel]
}

extension MainSectionModel: SectionModelType {
    typealias Item = MainRowModel
    
    init(original: MainSectionModel, items: [MainRowModel]) {
        self = original
        self.items = items
    }
}

struct MainRowModel {
    let title: String
    let type: MainRowType
}

enum MainRowType {
    case debounce
}

extension MainModel {
    static func getInitialModel() -> MainModel {
            return MainModel(
                sections: [
                    MainSectionModel(
                        title: "Filtering",
                        items: [
                            MainRowModel(
                                title: "Debounce",
                                type: .debounce
                            )
                        ]
                    )
                ]
            )
    }
}
