//
//  CountryListAssembly.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit

class CountryListAssembly {
    class func createVC() -> UIViewController {
        
        let presenter = CountryListPresenter()
        
        let vc = CountryListViewController(nibName: "CountryListViewController", bundle: nil)
        presenter.view = vc
        vc.output = presenter
        
        let interactor = CountryListInteractor()
        presenter.interactor = interactor
        interactor.output = presenter
        
        let router = CountryListRouter()
        presenter.router = router
        
        return vc
    }
}
