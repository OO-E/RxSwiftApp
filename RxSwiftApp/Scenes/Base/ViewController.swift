//
//  ViewController.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 27.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController, NVActivityIndicatorViewable {
   
    override func viewDidLoad() {
        setupNavigationBar()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    deinit {
        print("OS reclaiming memory for \(String(describing: self)). No Retain Cycle/Leak")
    }
    
}
