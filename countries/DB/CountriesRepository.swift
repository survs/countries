//
//  CountriesRepository.swift
//  countries
//
//  Created by Кирилл Баюков on 26.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit
import CoreData

class CountriesRepository {
    
    typealias SuccessBlock = (Bool) -> ()
    
    private var mainContext: NSManagedObjectContext
    private var privateContext: NSManagedObjectContext
    
    let entityName = "CountryEntity"
    
    static let shared = CountriesRepository()
    
    init() {
        
        guard let objectModelUrl = Bundle.main.url(forResource: "countries", withExtension: "momd") else {
            fatalError("[LocalWorker] - Error: Could not load model from bundle")
        }
        
        guard let objectModel = NSManagedObjectModel(contentsOf: objectModelUrl) else {
            fatalError("[LocalWorker] - Error: Could not init model from \(objectModelUrl)")
        }
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)
        
        self.mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        self.mainContext.persistentStoreCoordinator = coordinator
        let fileManagerUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentUrl = fileManagerUrls[fileManagerUrls.endIndex - 1]
        
        let storeUrl = documentUrl.appendingPathComponent(self.entityName + ".sqlite")
        let options = [NSMigratePersistentStoresAutomaticallyOption: true,
                       NSInferMappingModelAutomaticallyOption: true]
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: options)
        } catch let error {
            fatalError("Error: Could not migrate store: \(error.localizedDescription)")
        }
        self.privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        self.privateContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        self.privateContext.parent = self.mainContext
        
    }
    
    func storeCountries(countries: [CountryModel], completion: @escaping(Bool) -> Void) {
        self.fetchCountries { [weak self] storedCountries in
            guard let self = self else { return }
            let countries = countries.filter { newCountry -> Bool in
                return !(storedCountries?.contains(where: { $0.name == newCountry.name }) ?? false)
            }
            if countries.isEmpty {
                completion(true)
                return
            }
            guard let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: self.privateContext) else { return }
            let _ = countries.map({ self.privateContext.insert($0.mapToRepository(entity: entity, context: self.privateContext)) })
            self.savePrivateContext(completion: completion)
        }
    }
    
    func updateCountry(country: CountryModel) {
        guard let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: self.privateContext) else { return }
        self.privateContext.insert(country.mapToRepository(entity: entity, context: self.privateContext))
        self.savePrivateContext { _ in }
    }
    
    func fetchCountries(completion: @escaping([CountryModel]?) -> Void) {
        let request = NSFetchRequest<CountryEntity>(entityName: self.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let result = try? self.privateContext.fetch(request)
        completion(result?.map({ $0.mapToModel() }))
    }
    
    func cleanRepository(completion: @escaping(Bool) -> Void) {
        let request = NSFetchRequest<CountryEntity>(entityName: self.entityName)
        guard let result = try? self.privateContext.fetch(request) else { return }
        self.privateContext.perform {
            for entity in result {
                self.privateContext.delete(entity)
            }
            
            self.savePrivateContext(completion: { result in
                completion(result)
            })
        }
    }
    
    private func savePrivateContext(completion: @escaping(Bool) -> Void) {
        self.privateContext.perform {
            if self.privateContext.hasChanges {
                do {
                    try self.privateContext.save()
                    self.saveMainContext()
                    completion(true)
                } catch let error {
                    NSLog("Error: Could not save context: \(error.localizedDescription)")
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    
    private func saveMainContext() {
        self.mainContext.performAndWait {
            do {
                try self.mainContext.save()
                NSLog("Success saving main managed object context")
            } catch let error {
                NSLog("Error: Could not save main managed object context: \(error.localizedDescription)")
            }
        }
    }
    
}
