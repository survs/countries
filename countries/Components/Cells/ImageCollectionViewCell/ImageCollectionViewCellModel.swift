//
//  ImageCollectionViewCellModel.swift
//  countries
//
//  Created by Кирилл Баюков on 26.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit

class ImageCollectionViewCellModel {
    
    var image: UIImage
    
    static let identifier = "imageCell"
    
    static let cellSize = CGSize(width: UIScreen.main.bounds.size.width, height: 200)
    
    init(image: UIImage) {
        self.image = image
    }
    
    var showImage: (() -> Void)?
    
}
