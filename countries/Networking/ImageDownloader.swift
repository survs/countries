//
//  ImageDownloader.swift
//  countries
//
//  Created by Кирилл Баюков on 26.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit

class ImageDownloader {
    
    class func downloadImages(urls: [URL], completion: @escaping([UIImage]) -> Void) {
        DispatchQueue.global(qos: .default).async {
            let group = DispatchGroup()
            var images: [Any] = urls
            for url in urls {
                group.enter()
                Network.session.dataTask(with: url) { (data, response, error) in
                    if let data = data, let image = UIImage(data: data), let index = images.firstIndex(where: { ($0 as? URL)?.relativePath == response?.url?.relativePath }) {
                        images.remove(at: index)
                        images.insert(image, at: index)
                    }
                    group.leave()
                }.resume()
            }
            group.notify(queue: .global()) {
                images.removeAll(where: { !($0 is UIImage) })
                guard let images = images as? [UIImage] else { return }
                completion(images)
            }
        }
    }
    
}
