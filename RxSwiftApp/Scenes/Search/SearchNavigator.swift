//
//  SearchNavigator.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 21.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import UIKit

protocol SearchNavigatable {
    func navigateToWeatherDetailScreen(withModel model:Result)
}

final class SearchNavigator: SearchNavigatable {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToWeatherDetailScreen(withModel model:Result) {
        let detailNavigator = DetailNavigator(navigationController: navigationController)
        let detailViewModel = DetailViewModel(dependencies: DetailViewModel.Dependencies(result: model, navigator: detailNavigator))
        let detailViewController = UIStoryboard.main.detailViewController
        detailViewController.viewModel = detailViewModel
        
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
