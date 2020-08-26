//
//  ImageCollectionViewCell.swift
//  countries
//
//  Created by Кирилл Баюков on 26.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    var model: ImageCollectionViewCellModel? {
        didSet {
            self.updateView()
        }
    }
    
    func updateView() {
        self.imageView.image = self.model?.image
        self.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedImage)))
        self.imageView.isUserInteractionEnabled = true
    }
    
    @objc
    func tappedImage() {
        self.model?.showImage?()
    }

}
