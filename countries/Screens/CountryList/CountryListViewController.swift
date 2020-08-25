//
//  CountryListViewControlerViewController.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit


protocol CountryListViewInput: AnyObject {

}

protocol CountryListViewOutput: AnyObject {
    func reloadData()
}

class CountryListViewController: UIViewController, CountryListViewInput {
    
    // MARK: - properties
    
    var output: CountryListViewOutput?
    
    // MARK: - Outlets
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.reloadData()
        self.setupView()
    }
    
    func setupView() {
        self.title = R.string.localizable.country_list()
    }
    
    // MARK: - CurrencyViewInput
    
    
    // MARK: - IBAction

}
