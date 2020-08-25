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
    
    
    // MARK: - ViewOutput
    
    func reloadData() {
        self.entity.nextPageURL = Network.initialPageURL
        if let url = self.entity.nextPageURL {
            self.interactor?.fetchPage(url: url)
        }
    }
    
    // MARK: - InteractorOutput
    
    func loadedPage(page: CountryPageModel) {
        self.entity.nextPageURL = page.nextPage
        self.entity.countries.append(contentsOf: page.countries)
        self.makeSections()
    }
    
    func loadError(error: Error) {
        
    }
    
    
    //MARK: - Module functions
    
    func makeSections() {
        let sections = self.entity.countries.map({ CountryListTableViewCellModel(country: $0) })
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.madeSections(sections: sections)
        }
    }
    
}
