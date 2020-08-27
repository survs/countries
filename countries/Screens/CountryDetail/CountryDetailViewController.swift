//
//  CountryDetailViewController.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit
import Agrume

protocol CountryDetailViewInput: AnyObject {
    func loadedCountry(country: CountryModel)
    func madeSections(sections: [ImageCollectionViewCellModel])
    func openImage(image: UIImage)
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
    
    var sections: [ImageCollectionViewCellModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.output?.viewDidLoad()
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
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(R.nib.imageCollectionViewCell)
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
    
    func madeSections(sections: [ImageCollectionViewCellModel]) {
        self.sections = sections
        self.collectionView.reloadData()
        self.pageControl.isHidden = sections.count <= 1
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = sections.count
    }
    
    func openImage(image: UIImage) {
        let agrume = Agrume(image: image)
        agrume.show(from: self)
    }

}


// MARK: - UICollectionViewDelegate

extension CountryDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ImageCollectionViewCellModel.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.item
    }
}


// MARK: - UICollectionViewDataSource

extension CountryDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCellModel.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        cell.model = self.sections[indexPath.item]
        return cell
    }
}
