//
//  CountryListInteractor.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import Foundation

protocol CountryListInteractorInput: AnyObject {
    func fetchPage(url: URL)
    func reloadData(url: URL)
}

protocol CountryListInteractorOutput: AnyObject {
    func loadedPage(page: CountryPageModel)
    func loadedCountries(countries: [CountryModel]?)
    func loadError(error: Error)
}

class CountryListInteractor: CountryListInteractorInput {
    
    var output: CountryListInteractorOutput?
    
    func reloadData(url: URL) {
        CountriesRepository.shared.cleanRepository { [weak self] _ in
            guard let self = self else { return }
            self.fetchPage(url: url)
        }
    }
    
    func fetchPage(url: URL) {
        Network.fetchPage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(page):
                self.output?.loadedPage(page: page)
                self.saveCountries(countries: page.countries)
            case let .failure(error):
                self.output?.loadError(error: error)
                self.fetchCountries()
                break
            }
        }
    }
    
    func saveCountries(countries: [CountryModel]) {
        CountriesRepository.shared.storeCountries(countries: countries) { [weak self] success in
            guard let self = self else { return }
            if success {
                self.fetchCountries()
            }
        }
    }
    
    func fetchCountries() {
        CountriesRepository.shared.fetchCountries { [weak self] countries in
            guard let self = self else { return }
            self.output?.loadedCountries(countries: countries)
        }
    }
    
    
}
