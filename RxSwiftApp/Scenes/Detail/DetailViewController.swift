//
//  DetailViewController.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 27.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: ViewController {
    
    var viewModel: DetailViewModel!
    @IBOutlet weak var detailHeaderView: DetailHeaderView!
    
    let backButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: String(describing: ListCell.self), bundle: nil),
                               forCellReuseIdentifier: String(describing: ListCell.self))
        }
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = backButtonItem
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func bindViewModel() {
        
        let input = DetailViewModel.Input(ready: rx.viewWillAppear.asDriver(),
                                          backTrigger: backButtonItem.rx.tap.asDriver(),
                                          selected: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.result
            .drive(onNext: { [weak self] data in
            guard let data = data,
                let strongSelf = self else { return }
            strongSelf.detailHeaderView.configure(withResultModel: data)
        })
            .disposed(by: disposeBag)
        
        output.list
            .drive(tableView.rx.items(cellIdentifier: String(describing: ListCell.self), cellType: ListCell.self)) { (row, element, cell) in
                cell.configure(withResultListItemViewModel: element)
            }
            .disposed(by: disposeBag)

        output.back
            .drive()
            .disposed(by: disposeBag)
        
        output.selectedDone
            .drive()
            .disposed(by: disposeBag)
        
    }
}
