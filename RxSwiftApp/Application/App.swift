//
//  App.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 27.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import UIKit

final class App {
    static let shared = App()
    
    func startInterface(in window: UIWindow) {
        let searchNavigationController = UINavigationController()
        let searchNavigator = SearchNavigator(navigationController: searchNavigationController)
        let searchViewModel = SearchViewModel(dependencies: SearchViewModel.Dependencies(api: ClientApi(), navigator: searchNavigator))
        let searchViewController = UIStoryboard.main.searchViewController
        searchViewController.viewModel = searchViewModel
        
        searchNavigationController.viewControllers = [searchViewController]
        
        window.rootViewController = searchNavigationController
        window.makeKeyAndVisible()
    }
}

