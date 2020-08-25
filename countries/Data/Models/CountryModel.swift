//
//  CountryModel.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit

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
    
    var imageURLS: [URL?] {
        return self.imagePaths.map({ URL(string: $0) })
    }
}