//
//  CountryListRouter.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit

protocol CountryListRouterInput: AnyObject {
    func openCountry(country: CountryModel)
}

class CountryListRouter: CountryListRouterInput {
    
    var navigationController: UINavigationController?
    
    func openCountry(country: CountryModel) {
        let vc = CountryDetailAssembly.createVC(country: country)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
