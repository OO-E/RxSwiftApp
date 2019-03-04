//
//  UIStoryboard+ViewControllers.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 21.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension UIStoryboard {
    var searchViewController: SearchViewController {
        guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {
            fatalError("SearchViewController couldn't be found in Storyboard file")
        }
        return vc
    }
    
    var detailViewController: DetailViewController {
        guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            fatalError("DetailViewController couldn't be found in Storyboard file")
        }
        return vc
    }
    
    var moreDetailViewController: MoreDetailViewController {
        guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "MoreDetailViewController") as? MoreDetailViewController else {
            fatalError("MoreDetailViewController couldn't be found in Storyboard file")
        }
        return vc
    }
}
