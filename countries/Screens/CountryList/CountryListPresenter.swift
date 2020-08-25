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
        if !self.entity.isLoading {
            self.entity.nextPageURL = Network.initialPageURL
            self.entity.countries = []
            self.makeSections()
            self.entity.isLoading = true
            self.entity.isLoadedAll = false
            if let url = self.entity.nextPageURL {
                self.interactor?.fetchPage(url: url)
            }
        }
    }
    
    
    func displayedCell(row: Int) {
        if row == self.entity.countries.count - 2 {
            self.loadData()
        }
    }
    
    // MARK: - InteractorOutput
    
    func loadedPage(page: CountryPageModel) {
        self.entity.nextPageURL = page.nextPage
        self.entity.countries.append(contentsOf: page.countries)
        self.makeSections()
        self.entity.isLoading = false
        self.entity.isLoadedAll = page.nextPage == nil
    }
    
    func loadError(error: Error) {
        self.entity.isLoading = false
    }
    
    
    //MARK: - Module functions
    
    func loadData() {
        if !self.entity.isLoadedAll && !self.entity.isLoading {
            guard let url = self.entity.nextPageURL else { return }
            self.entity.isLoading = true
            self.interactor?.fetchPage(url: url)
        }
    }
    
    func makeSections() {
        let sections = self.entity.countries.map({ CountryListTableViewCellModel(country: $0) })
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.madeSections(sections: sections)
        }
    }
    
}
