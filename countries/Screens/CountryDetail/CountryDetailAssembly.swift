//
//  CountryDetailAssembly.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import Foundation

import UIKit

class CountryDetailAssembly {
    class func createVC(country: CountryModel) -> UIViewController {
        
        let presenter = CountryDetailPresenter(country: country)
        
        let vc = CountryDetailViewController(nibName: "CountryDetailViewController", bundle: nil)
        presenter.view = vc
        vc.output = presenter
        
        let interactor = CountryDetailInteractor()
        presenter.interactor = interactor
        interactor.output = presenter
        
        let router = CountryDetailRouter()
        presenter.router = router
        
        return vc
    }
}
