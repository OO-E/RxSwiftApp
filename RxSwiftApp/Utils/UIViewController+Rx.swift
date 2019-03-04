//
//  UIViewController+Rx.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 21.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear(_:))).map { _ in }
        return ControlEvent(events: source)
    }
}

extension UIViewController {
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let image = UIImage(named: "NavBarLogo")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        self.navigationItem.titleView = imageView
    }
}
