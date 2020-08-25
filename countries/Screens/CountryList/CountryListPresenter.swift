//
//  CountryListPresenter.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import Foundation

protocol CountryListPresenterInput {
    
}

class CountryListPresenter: CountryListPresenterInput, CountryListViewOutput, CountryListInteractorOutput {
    
    
    weak var view: CountryListViewInput?
    var router: CountryListRouterInput?
    
    var interactor: CountryListInteractorInput?
    
    let entity = CountryListEntity()
    
    
    // MARK: - InteractorOutput
    
    
    //MARK: - Module functions
    
}
