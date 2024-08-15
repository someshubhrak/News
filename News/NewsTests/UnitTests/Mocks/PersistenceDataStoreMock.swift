//
//  PersistenceDataStoreMock.swift
//  SwiftDataTests
//
//  Created by Someshubhra Karmakar on 15/08/24.
//

import Foundation
@testable import News

class PersistenceDataStoreMock: PersistenceDataStoreType {
    func addToBookMarkItems(item: NewsFeedDataModel.NewsFeedItem) throws {}
    
    func deleteAllBookedMarkedItems() throws {}
    
    func deleteBookedMarked(item: NewsFeedDataModel.NewsFeedItem) throws {}

    var bookMarkedItems: [PersistenceDataStore.BookmarkedNewsItem] = []
    func fetchBookMarkedItems() throws -> [PersistenceDataStore.BookmarkedNewsItem] {
        bookMarkedItems
    }
}
