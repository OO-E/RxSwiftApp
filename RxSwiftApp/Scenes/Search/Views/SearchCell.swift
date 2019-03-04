//
//  CityTableViewCell.swift
//  MobvenWeatherApp
//
//  Created by Gökhan Aydın on 26.10.2018.
//  Copyright © 2018 Gökhan Aydın. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var latlonLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(withCityName cityName: String?,
                   countryCode: String,
                   lat: Double,
                   long: Double) {
        self.cityNameLabel.text = cityName
        self.countryCodeLabel.text = "Country Code : \(countryCode)"
        self.latlonLabel.text = "Lat : \(lat) \nLon : \(long)"
    }
    
}

extension SearchCell {
    func configure(withSearchResultItemViewModel item: Result) {
        configure(withCityName : item.city?.name,
                  countryCode: (item.city?.country)!,
                  lat: (item.city?.coord?.lat)!,
                  long: (item.city?.coord?.lon)!)
    }
}
