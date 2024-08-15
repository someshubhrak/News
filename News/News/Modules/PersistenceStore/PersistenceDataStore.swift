//
//  PersistenceDataStore.swift
//  News
//
//  Created by Someshubhra Karmakar on 11/08/24.
//

import Foundation
import SwiftData

/// Abstraction for PersistenceDataStore
protocol PersistenceDataStoreType {
    func addToBookMarkItems(item: NewsFeedDataModel.NewsFeedItem) throws
    func deleteAllBookedMarkedItems() throws
    func deleteBookedMarked(item: NewsFeedDataModel.NewsFeedItem) throws
    func fetchBookMarkedItems() throws -> [PersistenceDataStore.BookmarkedNewsItem]
}

/// Uses Swift Data to store objects persistencely
class PersistenceDataStore: PersistenceDataStoreType {
    let container: ModelContainer

    init() throws {
        let schema = Schema( [BookmarkedNewsItem.self])
        let configuration = ModelConfiguration()
        self.container = try ModelContainer(for: schema, configurations: configuration)
    }

    @MainActor func addToBookMarkItems(item: NewsFeedDataModel.NewsFeedItem) throws  {
        let bookMarkedItem = item.bookMarkedFeedItem
        container.mainContext.insert(bookMarkedItem)
        try container.mainContext.save()
    }

    @MainActor func deleteAllBookedMarkedItems() throws  {
        try container.mainContext.delete(model: BookmarkedNewsItem.self)
        try container.mainContext.save()
    }

    @MainActor func deleteBookedMarked(item: NewsFeedDataModel.NewsFeedItem) throws  {
        let title = item.title
        try container.mainContext.delete(model: BookmarkedNewsItem.self, where: #Predicate {
            $0.title == title
          })
        try container.mainContext.save()
    }

    @MainActor func fetchBookMarkedItems() throws -> [BookmarkedNewsItem] {
        let fetchDesc = FetchDescriptor<BookmarkedNewsItem>()
        let newsItems = try container.mainContext.fetch(fetchDesc)
        return newsItems
        
    }
}

// MARK: Tests
extension PersistenceDataStore {
    @MainActor func addDataContainer() throws {
//        let newsItemA = BookmarkedNewsItem(title: "News A", url: "url_A", sourceName: "sourceA")
//        container.mainContext.insert(newsItemA)
//    
//        let newsItemB = BookmarkedNewsItem(title: "News B", url: "url_B", sourceName: "sourceA")
//        container.mainContext.insert(newsItemB)
//
//        let newsItemC = BookmarkedNewsItem(title: "News C", url: "url_C", sourceName: "sourceB")
//        container.mainContext.insert(newsItemC)
//
//        try container.mainContext.save()
    }
}
