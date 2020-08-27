//
//  Network.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import Foundation

class Network {
    
    static let initialPageURL = URL(string: "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json")
    
    static var session: URLSession {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        return URLSession(configuration: config)
    }
    
    static func fetchPage(url: URL, completion: @escaping(Result<CountryPageModel, Error>) -> Void) {
        
        
        Network.session.dataTask(with: url) { (data, _, error) in
            if let data = data, let page = try? JSONDecoder().decode(CountryPageResponse.self, from: data) {
                completion(.success(page.mapToModel()))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(NSError()))
            }
        }.resume()
    }
}
