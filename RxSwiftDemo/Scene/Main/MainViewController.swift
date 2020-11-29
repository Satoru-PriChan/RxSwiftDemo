//
//  MainViewController.swift
//  RxSwiftDemo
//
//  Created by 999-503 on 2020/10/25.
//  Copyright © 2020 SoLaMi Smile. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class MainViewController: UIViewController
{
    private let disposeBag = DisposeBag()
    private let cellTappedRelay = PublishRelay<MainRowModel>()
    var cellTappedSignal: Signal<MainRowModel> {
        cellTappedRelay.asSignal()
    }

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Inner Injecter / DI parameters
    func inject(by inner: InnerDependency)
    {
        viewModel = inner.viewModel
    }
    private var viewModel: MainViewModel!
    {
        didSet { bind() }
    }

    // MARK: - life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setTableView()
    }
}

// MARK: - private func (binding)
extension MainViewController
{
    
    private func setTableView() {
        // binding VM behaivor
        // example:
        let dataSource = RxTableViewSectionedReloadDataSource<MainSectionModel>(configureCell: { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath)
            cell.textLabel?.text = item.title
            return cell
        })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].title
        }
        
               
        viewModel.outputs.tableViewDriver
            .map { $0.sections }
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MainCell")
        
        tableView.rx.modelSelected(MainRowModel.self)
            .subscribe(onNext: { [weak self] model in
                guard let `self` = self else { return }
                self.cellTappedRelay.accept(model)
            })
            .disposed(by: disposeBag)
    }
    
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

        guard let viewModel = viewModel else {
            Logger.debug("cannot bind by viewModel.")
            return
        }
    }
}

// MARK: - private func (etc)
private extension MainViewController
{

}
