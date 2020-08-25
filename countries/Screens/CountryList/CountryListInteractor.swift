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
}

protocol CountryListInteractorOutput: AnyObject {
    func loadedPage(page: CountryPageModel)
    func loadError(error: Error)
}

class CountryListInteractor: CountryListInteractorInput {
    
    var output: CountryListInteractorOutput?
    
    func fetchPage(url: URL) {
        Network.fetchPage(url: url) { result in
            switch result {
            case let .success(page):
                self.output?.loadedPage(page: page)
            case let .failure(error):
                self.output?.loadError(error: error)
                break
            }
        }
    }
    
    
}
