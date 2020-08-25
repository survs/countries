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
        // Initialization code
    }
    
    func setup() {
        guard let model = self.model else { return }
        self.countryLabel.text = model.country.name
        self.capitalLabel.text = model.country.capital
        self.descriptionLabel.text = model.country.descriptionShort.isEmpty ? nil : model.country.descriptionShort
        self.descriptionLabelTopConstraint.constant = model.descriptionTopConstraint
    }
    
    
}
