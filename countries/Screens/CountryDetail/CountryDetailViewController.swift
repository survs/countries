//
//  CountryDetailViewController.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit

protocol CountryDetailViewInput: AnyObject {
    func loadedCountry(country: CountryModel)
}

protocol CountryDetailViewOutput: AnyObject {
    func viewDidLoad()
}

class CountryDetailViewController: UIViewController, CountryDetailViewInput {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var capitalWordLabel: UILabel!
    @IBOutlet private weak var capitalLabel: UILabel!
    @IBOutlet private weak var populationWordLabel: UILabel!
    @IBOutlet private weak var populationLabel: UILabel!
    @IBOutlet private weak var continentWordLabel: UILabel!
    @IBOutlet private weak var continentLabel: UILabel!
    @IBOutlet private weak var aboutWordLabel: UILabel!
    @IBOutlet private weak var aboutLabel: UILabel!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    var output: CountryDetailViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.output?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        self.countryLabel.textColor = R.color.secondaryTextColor()
        self.countryLabel.font = .systemFont(ofSize: 22, weight: .bold)
        
        for label in [self.capitalWordLabel, self.capitalLabel, self.populationLabel, self.populationWordLabel, self.continentLabel, self.continentWordLabel] {
            label?.textColor = R.color.secondaryTextColor()
            label?.font = .systemFont(ofSize: 17, weight: .regular)
        }
        
        self.aboutWordLabel.textColor = R.color.secondaryTextColor()
        self.aboutWordLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        self.aboutLabel.textColor = R.color.secondaryTextColor()
        self.aboutLabel.font = .systemFont(ofSize: 15, weight: .regular)
        
        self.capitalWordLabel.text = R.string.localizable.capital()
        self.populationWordLabel.text = R.string.localizable.population()
        self.continentWordLabel.text = R.string.localizable.continent()
        self.aboutWordLabel.text = R.string.localizable.about_country()
    }
    
    // MARK: - ViewInput
    
    func loadedCountry(country: CountryModel) {
        self.title = country.name
        self.countryLabel.text = country.name
        self.capitalLabel.text = country.capital
        self.continentLabel.text = country.contitnent
        self.aboutLabel.text = country.description
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        self.populationLabel.text = formatter.string(from: country.population as NSNumber)
    }

}
