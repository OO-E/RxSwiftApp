//
//  ListItemTableViewCell.swift
//  MobvenWeatherApp
//
//  Created by Gökhan Aydın on 26.10.2018.
//  Copyright © 2018 Gökhan Aydın. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var dateYearMonthDayLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(withDateText dateText: String?,
                   hour: String?) {
        self.dateYearMonthDayLabel.text = dateText
        self.hourLabel.text = hour
    }
    
}

extension ListCell {
    func configure(withResultListItemViewModel item: ListItem) {
        configure(withDateText: item.dt_txt?.components(separatedBy: " ")[0],
                  hour: item.dt_txt?.components(separatedBy: " ")[1])
    }
}
