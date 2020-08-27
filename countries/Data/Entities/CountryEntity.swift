//
//  CountryEntity.swift
//  countries
//
//  Created by Кирилл Баюков on 26.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import Foundation
import CoreData

@objc(CountryEntity)
public class CountryEntity: NSManagedObject {
    
    @NSManaged public var name: String?
    @NSManaged public var continent: String?
    @NSManaged public var capital: String?
    @NSManaged public var population: NSNumber?
    @NSManaged public var descShort: String?
    @NSManaged public var desc: String?
    @NSManaged public var flagPath: String?
    @NSManaged public var flagURL: URL?
    @NSManaged public var imagePaths: NSObject?
    @NSManaged public var imageURLS: NSObject?
    
    func mapToModel() -> CountryModel {
        let model = CountryModel()
        model.name = self.name ?? ""
        model.contitnent = self.continent ?? ""
        model.capital = self.capital ?? ""
        model.population = UInt64(truncating: self.population ?? 0)
        model.descriptionShort = self.descShort ?? ""
        model.description = self.desc ?? ""
        model.flagPath = self.flagPath ?? ""
        model.imagePaths = self.imagePaths as? [String] ?? []
        return model
    }
}
