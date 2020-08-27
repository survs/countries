//
//  CountryDetailPresenter.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit

protocol CountryDetailPresenterInput {
    
}

class CountryDetailPresenter: CountryDetailPresenterInput, CountryDetailViewOutput, CountryDetailInteractorOutput {
    
    
    weak var view: CountryDetailViewInput?
    var router: CountryDetailRouterInput?
    
    var interactor: CountryDetailInteractorInput?
    
    let entity: CountryDetailEntity
    
    init(country: CountryModel) {
        self.entity = CountryDetailEntity(country: country)
    }
    
    
    // MARK: - ViewOutput
    
    func viewDidLoad() {
        self.view?.loadedCountry(country: self.entity.country)
        if self.entity.country.images != nil {
            self.makeSections()
        } else if let imageURLs = self.entity.country.imageURLs {
            self.interactor?.downloadImages(urls: imageURLs)
        } else if let flag = self.entity.country.flagImage {
            self.entity.country.images = [flag]
            self.makeSections()
        } else if let flagURL = self.entity.country.flagUrl {
            self.entity.isTryingToLoadFlag = false
            self.interactor?.downloadImages(urls: [flagURL])
        }
    }
    
    // MARK: - InteractorOutput
    
    func loadedImages(images: [UIImage], urls: [URL]) {
        if images.isEmpty, !self.entity.isTryingToLoadFlag, let flagURL = self.entity.country.flagUrl {
            self.entity.isTryingToLoadFlag = true
            self.interactor?.downloadImages(urls: [flagURL])
        } else {
            self.entity.country.images = images
            self.entity.country.localImageURLs = urls
            self.interactor?.updateCountry(country: self.entity.country)
            self.makeSections()
        }
    }
    
    
    //MARK: - Module functions
    
    func makeSections() {
        if let images = self.entity.country.images {
            var sections: [ImageCollectionViewCellModel] = []
            for image in images {
                let model = ImageCollectionViewCellModel(image: image)
                model.showImage = {
                    self.view?.openImage(image: image)
                }
                sections.append(model)
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.view?.madeSections(sections: sections)
            }
        }
    }
    
    
}
