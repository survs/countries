//
//  CountryPageResponse.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import Foundation

struct CountryPageResponse {
    var nextPage: String?
    var countries: [CountryResponse]?
    
    enum CodingKeys: String, CodingKey {
        case nextPage = "next"
        case countries
    }
    
    func mapToModel() -> CountryPageModel {
        let model = CountryPageModel()
        model.nextPage = URL(string: self.nextPage ?? "")
        model.countries = self.countries?.map({ $0.mapToModel() }) ?? []
        return model
    }
}
