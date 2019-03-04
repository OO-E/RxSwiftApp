//
//  DetailHeaderView.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 28.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func configure(withDateText cityName: String,
                   startDateText: String, endDateText: String) {
        self.cityLabel.text = cityName
        self.startDateLabel.text = startDateText
        self.endDateLabel.text = endDateText
    }
    
    private func setup() {
        Bundle.main.loadNibNamed("DetailHeaderView", owner: self, options: nil)
        addSubview(contentView)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
}

extension DetailHeaderView {
    func configure(withResultModel model: Result) {
        configure(withDateText: (model.city?.name)!,
                  startDateText: (model.list.first?.dt_txt?.components(separatedBy: " ")[0])!, endDateText: (model.list.last?.dt_txt?.components(separatedBy: " ")[0])!)
    }
}
