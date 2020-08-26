//
//  CountryDetailPresenter.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import Foundation

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
    }
    
    // MARK: - InteractorOutput
    
    
    
    
    //MARK: - Module functions
    
    
}
