//
//  CountryListTableViewCellModel.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit

class CountryListTableViewCellModel {
    
    let country: CountryModel
    
    static let identifier = "countryListCell"
    
    var descriptionTopConstraint: CGFloat {
        return country.descriptionShort.isEmpty ? 0 : 8
    }
    
    init(country: CountryModel) {
        self.country = country
    }
    
}
