//
//  SearchViewController.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 21.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: ViewController {
    
    var viewModel: SearchViewModel!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: String(describing: SearchCell.self), bundle: nil),
                               forCellReuseIdentifier: String(describing: SearchCell.self))
        }
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchNavigationController = self.navigationController
        let searchNavigator = SearchNavigator(navigationController: searchNavigationController!)
        let searchViewModel = SearchViewModel(dependencies: SearchViewModel.Dependencies(api: ClientApi(), navigator: searchNavigator))
        self.viewModel = searchViewModel
        
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func bindViewModel() {
        let input = SearchViewModel.Input(searchText: searchTextField.rx.text.orEmpty.asDriver(),
                                          selected: tableView.rx.itemSelected.asDriver(),
                                          searchTaps : searchButton.rx.tap.asSignal()
        )
        
        let output = viewModel.transform(input: input)
        
//        output.loading
//            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
//            .disposed(by: disposeBag)
        
        output.loading
            .filter{ boolValue in
                if(boolValue) {
                    self.startAnimating()
                }
                else {
                    self.stopAnimating()
                }
                return boolValue
            }
            .drive()
            .disposed(by: disposeBag)

        
        output.results
            .filter { results in
                if(results.first?.error != nil) {
                    let alert = UIAlertController(title: "Oops Error :(", message: results.first?.error?.message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                    self.present(alert, animated: true, completion: nil)
                    return false
                }
                return true
            }
            .drive(tableView.rx.items(cellIdentifier: String(describing: SearchCell.self), cellType: SearchCell.self)) { (row, element, cell) in
                cell.configure(withSearchResultItemViewModel: element)
            }
            .disposed(by: disposeBag)
        
        output.selectedDone
            .drive()
            .disposed(by: disposeBag)
    }
}

