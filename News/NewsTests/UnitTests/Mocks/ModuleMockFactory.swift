//
//  ModuleMockFactory.swift
//  SwiftDataTests
//
//  Created by Someshubhra Karmakar on 14/08/24.
//

import Foundation
@testable import News

class ModuleMockFactory: ModuleFactoryType {
    let newsFeedDataManagerMock =  NewsFeedDataManagerMock()
    let persistenceStoreMock =  PersistenceDataStoreMock()

    var persistenceStore: PersistenceDataStoreType? { persistenceStoreMock }
    var newsFeedDataManager: NewsFeedDataManagerType { newsFeedDataManagerMock }
}

