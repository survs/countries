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
    
    func viewDidLoad() {
        self.loadData()
    }
    
    func reloadData() {
        if !self.entity.isLoading {
            self.entity.nextPageURL = Network.initialPageURL
            self.entity.countries = []
            self.makeSections()
            self.entity.isLoading = true
            self.entity.isLoadedAll = false
            if let url = self.entity.nextPageURL {
                self.interactor?.reloadData(url: url)
            }
        }
    }
    
    
    func displayedCell(row: Int) {
        if row == self.entity.countries.count - 2 {
            self.loadData()
        }
    }
    
    func selectedCell(row: Int) {
        if row < self.entity.countries.count {
            self.router?.openCountry(country: self.entity.countries[row])
        }
    }
    
    // MARK: - InteractorOutput
    
    func loadedPage(page: CountryPageModel) {
        self.entity.nextPageURL = page.nextPage
        self.entity.isLoading = false
        self.entity.isLoadedAll = page.nextPage == nil
    }
    
    func loadError(error: Error) {
        self.entity.isLoading = false
        self.entity.isLoadedAll = true
    }
    
    func loadedCountries(countries: [CountryModel]?) {
        if let countries = countries, !countries.isEmpty, countries != self.entity.countries {
            self.entity.countries = countries
            self.makeSections()
        }
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
        var sections: [CountryListTableViewCellModel] = []
        for country in self.entity.countries {
            let model = CountryListTableViewCellModel(country: country)
            if let flagURL = country.flagUrl {
                ImageDownloader.downloadImages(urls: [flagURL]) { [weak self] fileURLs, images in
                    guard let self = self else { return }
                    if country.localFlagURL?.lastPathComponent != fileURLs.first?.lastPathComponent {
                         country.localFlagURL = fileURLs.first
                        self.interactor?.updateCountry(country: country)
                    }
                    
                    DispatchQueue.main.async {
                        country.flagImage = images.first
                        model.loadedImages(country: country)
                    }
                }
            }
            sections.append(model)
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.madeSections(sections: sections)
        }
    }
    
    
}
