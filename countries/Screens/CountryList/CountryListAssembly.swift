//
//  CountryListAssembly.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit

class CountryListAssembly {
    class func createVC() -> CountryListViewController {
        let vc = CountryListViewController(nibName: "CountryListViewController", bundle: nil)
        return vc
    }
    
    class func configureVC(vc: CountryListViewController) {
        let presenter = CountryListPresenter()
        presenter.view = vc
        vc.output = presenter
        
        let interactor = CountryListInteractor()
        presenter.interactor = interactor
        interactor.output = presenter
        
        let router = CountryListRouter()
        router.navigationController = vc.navigationController
        presenter.router = router
    }
}
