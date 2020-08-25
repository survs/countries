//
//  CountryListInteractor.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import Foundation

protocol CountryListInteractorInput: AnyObject {
    
}

protocol CountryListInteractorOutput: AnyObject {
    
}

class CountryListInteractor: CountryListInteractorInput {
    
    var output: CountryListInteractorOutput?
    
    
}
