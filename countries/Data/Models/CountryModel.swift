//
//  CountryModel.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit
import CoreData

class CountryModel: Equatable {
    
    var name = ""
    var contitnent = ""
    var capital = ""
    var population: UInt64 = 0
    var descriptionShort = ""
    var description = ""
    var flagPath = ""
    var localFlagURL: URL?
    var flagImage: UIImage?
    var imagePaths: [String] = []
    var localImageURLs: [URL]?
    var images: [UIImage]?
    
    var flagUrl: URL? {
        return self.localFlagURL ?? URL(string: self.flagPath)
    }
    
    var imageURLs: [URL]? {
        var urls: [URL] = []
        if let localURLs = self.localImageURLs, !localURLs.isEmpty {
            urls.append(contentsOf: localURLs)
        } else {
            for path in self.imagePaths {
                if let url = URL(string: path) {
                    urls.append(url)
                }
            }
        }
        return urls.isEmpty ? nil : urls
    }
    
    static func == (lhs: CountryModel, rhs: CountryModel) -> Bool {
        return lhs.name == rhs.name
    }
    
    func mapToRepository(entity: NSEntityDescription, context: NSManagedObjectContext) -> CountryEntity {
        let entity = CountryEntity(entity: entity, insertInto: context)
        entity.name = self.name
        entity.capital = self.capital
        entity.continent = self.contitnent
        entity.desc = self.description
        entity.descShort = self.descriptionShort
        entity.population = self.population as NSNumber
        entity.imagePaths = self.imagePaths as NSObject
        entity.flagPath = self.flagPath
        entity.flagURL = self.localFlagURL
        entity.imageURLs = self.localImageURLs as NSObject?
        return entity
    }
}
