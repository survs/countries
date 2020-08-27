//
//  CountryModel.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit
import CoreData

class CountryModel {
    var name = ""
    var contitnent = ""
    var capital = ""
    var population: UInt64 = 0
    var descriptionShort = ""
    var description = ""
    var flagPath = ""
    var flagImage: UIImage?
    var imagePaths: [String] = []
    var images: [UIImage]?
    
    var flagUrl: URL? {
        return URL(string: self.flagPath)
    }
    
    var imageURLS: [URL]? {
        var urls: [URL] = []
        for path in self.imagePaths {
            if let url = URL(string: path) {
                urls.append(url)
            }
        }
        return urls.isEmpty ? nil : urls
    }
    
    func mapToRepository(entity: NSEntityDescription, context: NSManagedObjectContext) -> CountryEntity {//(entity: NSEntityDescription) -> CountryEntity {
        let entity = CountryEntity(entity: entity, insertInto: context)
        entity.name = self.name
        entity.capital = self.capital
        entity.desc = self.description
        entity.descShort = self.descriptionShort
        entity.population = self.population as NSNumber
        entity.imagePaths = self.imagePaths as NSObject
        entity.flagPath = self.flagPath
        return entity
    }
}
