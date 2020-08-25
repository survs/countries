//
//  CountryListEntity.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import Foundation

class CountryListEntity {
    var nextPageURL = Network.initialPageURL
    
    var countries: [CountryModel] = []
    
    var isLoading = false
    var isLoadedAll = false
}
