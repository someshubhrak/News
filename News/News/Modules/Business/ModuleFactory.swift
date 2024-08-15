//
//  ModuleFactory.swift
//  News
//
//  Created by Someshubhra Karmakar on 13/08/24.
//

import Foundation

/// Factory class For Module generations
/// Abstract Factory
protocol ModuleFactoryType {
    var persistenceStore: PersistenceDataStoreType? { get }
    var newsFeedDataManager: NewsFeedDataManagerType { get }
    var newsFeedService: NewsFeedServiceType { get }
}

// Factory class For Module generations
class ModuleFactory: ModuleFactoryType {
    static let shared = ModuleFactory()
    
    lazy var newsFeedDataManager: NewsFeedDataManagerType = { NewsFeedDataManager() }()
    lazy var persistenceStore: PersistenceDataStoreType? = { try? PersistenceDataStore() }()
    lazy var newsFeedService: NewsFeedServiceType = { NewsFeedService() }()

}
