//
//  CountryDetailInteractor.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit

protocol CountryDetailInteractorInput: AnyObject {
    func downloadImages(urls: [URL])
}

protocol CountryDetailInteractorOutput: AnyObject {
    func loadedImages(images: [UIImage])
}

class CountryDetailInteractor: CountryDetailInteractorInput {
    
    var output: CountryDetailInteractorOutput?
    
    func downloadImages(urls: [URL]) {
        ImageDownloader.downloadImages(urls: urls) { images in
            self.output?.loadedImages(images: images)
        }
    }
    
    
}
