//
//  CountryDetailEntity.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import Foundation

class CountryDetailEntity {
    let country: CountryModel
    
    var isTryingToLoadFlag = false
    
    init(country: CountryModel) {
        self.country = country
    }
}
