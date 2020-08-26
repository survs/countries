//
//  CountryDetailInteractor.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import Foundation

protocol CountryDetailInteractorInput: AnyObject {
    
}

protocol CountryDetailInteractorOutput: AnyObject {

}

class CountryDetailInteractor: CountryDetailInteractorInput {
    
    var output: CountryDetailInteractorOutput?
    
    
}
