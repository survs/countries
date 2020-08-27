//
//  CountryListTableViewCell.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {
    @IBOutlet private weak var flagImageView: UIImageView!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var capitalLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var descriptionLabelTopConstraint: NSLayoutConstraint!
    
    var model: CountryListTableViewCellModel? {
        didSet {
            self.setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        self.countryLabel.textColor = R.color.primaryTextColor()
        self.countryLabel.font = .systemFont(ofSize: 17, weight: .medium)
        
        self.capitalLabel.textColor = R.color.secondaryTextColor()
        self.capitalLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        self.descriptionLabel.textColor = R.color.secondaryTextColor()
        self.descriptionLabel.font = .systemFont(ofSize: 15, weight: .regular)
    }
    
    func setup() {
        guard let model = self.model else { return }
        self.countryLabel.text = model.country.name
        self.capitalLabel.text = model.country.capital
        self.descriptionLabel.text = model.country.descriptionShort.isEmpty ? nil : model.country.descriptionShort
        self.descriptionLabelTopConstraint.constant = model.descriptionTopConstraint
        self.flagImageView.image = model.country.flagImage
        model.updateFlag = {
            self.flagImageView.image = model.country.flagImage
        }
    }
    
    
}
