//
//  DetailNavigator.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 27.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import UIKit

protocol DetailNavigatable {
    func goBack()
    func navigateToWeatherMoreDetailScreen(withModel model:ListItem)
}

final class DetailNavigator: DetailNavigatable {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToWeatherMoreDetailScreen(withModel model:ListItem) {
        let moreDetailNavigator = MoreDetailNavigator(navigationController: navigationController!)
        let moreDetailViewModel = MoreDetailViewModel(dependencies: MoreDetailViewModel.Dependencies(result: model, navigator: moreDetailNavigator))
        let moreDetailViewController = UIStoryboard.main.moreDetailViewController
        moreDetailViewController.viewModel = moreDetailViewModel
        
        moreDetailViewController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        moreDetailViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        DispatchQueue.main.async {
            self.navigationController!.present(moreDetailViewController, animated: true, completion: nil)
        }
    }
    
    func goBack() {
        navigationController!.popViewController(animated: true)
    }
}
