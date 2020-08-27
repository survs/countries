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
    func updateCountry(country: CountryModel)
}

protocol CountryDetailInteractorOutput: AnyObject {
    func loadedImages(images: [UIImage], urls: [URL])
}

class CountryDetailInteractor: CountryDetailInteractorInput {
    
    var output: CountryDetailInteractorOutput?
    
    func downloadImages(urls: [URL]) {
        ImageDownloader.downloadImages(urls: urls) { [weak self] fileURLS, images in
            guard let self = self else { return }
            self.output?.loadedImages(images: images, urls: fileURLS)
        }
    }
    
    func updateCountry(country: CountryModel) {
        CountriesRepository.shared.updateCountry(country: country)
    }
    
}
