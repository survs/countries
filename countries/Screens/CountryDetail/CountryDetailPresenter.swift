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
        } else if let imageURLS = self.entity.country.imageURLS {
            self.interactor?.downloadImages(urls: imageURLS)
        } else if let flag = self.entity.country.flagImage {
            self.entity.country.images = [flag]
        } else if let flagURL = self.entity.country.flagUrl {
            self.entity.isTryingToLoadFlag = false
            self.interactor?.downloadImages(urls: [flagURL])
        }
    }
    
    // MARK: - InteractorOutput
    
    func loadedImages(images: [UIImage]) {
        if images.isEmpty, !self.entity.isTryingToLoadFlag, let flagURL = self.entity.country.flagUrl {
            self.interactor?.downloadImages(urls: [flagURL])
        } else {
            self.entity.country.images = images
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
