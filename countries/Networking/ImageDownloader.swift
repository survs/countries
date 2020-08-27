//
//  ImageDownloader.swift
//  countries
//
//  Created by Кирилл Баюков on 26.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

//for url in urls {
//    group.enter()
//    if let image = self.getSavedImage(url: url) {
//        let filename = UUID().uuidString + url.lastPathComponent
//        if let filepath = self.saveImage(image: image, path: filename) {
//            images.remove(at: index)
//            images.insert([filepath: image], at: index)
//        }
//    }
//
//}

import UIKit

class ImageDownloader {
    
    class func downloadImages(urls: [URL], completion: @escaping([URL], [UIImage]) -> Void) {
        DispatchQueue.global(qos: .default).async {
            var images: [Any] = urls
            var newURLS: [URL] = urls
            for url in urls {
                if url.scheme != "file" {
                    if let image = self.getSavedOrRemoteImage(url: url) {
                        let filename = UUID().uuidString + url.lastPathComponent
                        if let filepath = self.saveImage(image: image, path: filename), let index = images.firstIndex(where: { ($0 as? URL) == url }) {
                            images.remove(at: index)
                            newURLS.remove(at: index)
                            images.insert(image, at: index)
                            newURLS.insert(filepath, at: index)
                        }
                    }
                } else {
                    if let image = self.getSavedOrRemoteImage(url: url) {
                        if let index = images.firstIndex(where: { ($0 as? URL) == url }) {
                            images.remove(at: index)
                            images.insert(image, at: index)
                        }
                    }
                }
            }
            images.removeAll(where: { !($0 is UIImage) })
            guard let imagesArray = images as? [UIImage] else { return }
            completion(newURLS, imagesArray)
        }
    }
    
    class func saveImage(image: UIImage, path: String) -> URL? {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else { return nil }
        guard var directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("images/") as URL else { return nil }
        if !FileManager.default.fileExists(atPath: directory.path) {
            do {
                try FileManager.default.createDirectory(atPath: directory.path, withIntermediateDirectories: false, attributes: nil)
            } catch {
                return nil
            }
        }
        directory.appendPathComponent(path)
        do {
            try data.write(to: directory)
            return directory
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    class func getSavedOrRemoteImage(url: URL) -> UIImage? {
        var url = url
        if url.scheme == "file" {
            guard let newUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("images/").appendingPathComponent(url.lastPathComponent) as URL else { return(nil) }
            url = newUrl
        }
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        } catch {
            print(error)
            return nil
        }
    }
    
    class func clearImages(){
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("images/") as URL else { return }
        try? FileManager.default.removeItem(at: directory)
    }
    
}
