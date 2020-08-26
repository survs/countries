//
//  CountryResponse.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import Foundation

struct CountryInfoResponse: Decodable {
    var images: [String]?
    var flag: String?
    
    enum CodingKeys: String, CodingKey {
        case images
        case flag
    }
}

struct CountryResponse: Decodable {
    var name: String?
    var continent: String?
    var capital: String?
    var population: UInt64?
    var descriptionShort: String?
    var description: String?
    var image: String?
    var info: CountryInfoResponse?
    
    enum CodingKeys: String, CodingKey {
        case name
        case continent
        case capital
        case population
        case descriptionShort = "description_small"
        case description
        case image
        case info = "country_info"
    }
    
    func mapToModel() -> CountryModel {
        let model = CountryModel()
        model.name = self.name ?? ""
        model.contitnent = self.continent ?? ""
        model.capital = self.capital ?? ""
        model.population = self.population ?? 0
        model.descriptionShort = self.descriptionShort ?? ""
        model.description = self.description ?? ""
        model.flagPath = self.info?.flag ?? ""
        if let images = self.info?.images {
            model.imagePaths = images
        } else if let image = self.image {
            model.imagePaths = [image]
        } else {
            model.imagePaths = [model.flagPath]
        }
        return model
    }
    
}
