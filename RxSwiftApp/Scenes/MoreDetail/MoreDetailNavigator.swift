//
//  MoreDetailNavigator.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 1.03.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import UIKit

protocol MoreDetailNavigatable {
    func closePopUp()
}

final class MoreDetailNavigator: MoreDetailNavigatable {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func closePopUp() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
