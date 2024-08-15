//
//  NewsFeedDataManager.swift
//  News
//
//  Created by Someshubhra Karmakar on 11/08/24.
//

import Foundation
import Combine

protocol NewsFeedDataManagerType {
    /// bookmarkedItems
    var bookmarkedItems: [NewsFeedDataModel.NewsFeedItem] { get }

    /// Publisher for bookmarkedItems
    var bookmarkedItemsPublished: PassthroughSubject<[NewsFeedDataModel.NewsFeedItem],Never> { get }

    func loadNewsFeeds(searchTerm: String) async throws -> NewsFeedDataModel
    @MainActor func bookMark(newsItem: NewsFeedDataModel.NewsFeedItem) throws
    @MainActor func removeBookMark(newsItem: NewsFeedDataModel.NewsFeedItem) throws
}

/// This a class that routes and calls to different store
/// i.e from network service and local storage
/// This class acts as a wrapper to load and store methods.
class NewsFeedDataManager: ObservableObject, NewsFeedDataManagerType {
    
    private let moduleFactory: ModuleFactoryType
    private var persistenceStore: PersistenceDataStoreType? { moduleFactory.persistenceStore }

    /// Cache the book marked items and publish changes on it.
    var bookmarkedItems: [NewsFeedDataModel.NewsFeedItem] = [] {
        didSet {
            bookmarkedItemsPublished.send(bookmarkedItems)
        }
    }

    /// Publisher for bookmarkedItems
    var bookmarkedItemsPublished = PassthroughSubject<[NewsFeedDataModel.NewsFeedItem],Never>()

    init(moduleFactory: ModuleFactoryType = ModuleFactory.shared) {
        self.moduleFactory = moduleFactory
        Task { @MainActor in
            try? loadBookMarkedNewsFeedItems()
        }
    }
    
    func loadNewsFeeds(searchTerm: String) async throws -> NewsFeedDataModel {
        let queryParam = NewsFeedServiceQuery(searchTerm: searchTerm)
        var newsDataModel = try await NewsFeedService().fetch(query: queryParam)

        // Filter out the valid items
        newsDataModel.newsFeeds = newsDataModel.newsFeeds.filter { !$0.title.isEmpty && !$0.url.isEmpty }
        return newsDataModel
    }

    /// To be called in main thread
    @MainActor func bookMark(newsItem: NewsFeedDataModel.NewsFeedItem) throws {
        try persistenceStore?.addToBookMarkItems(item: newsItem)

        // Update bookmarked list
        bookmarkedItems = try persistenceStore?.fetchBookMarkedItems().map { $0.newsFeedItem } ?? []
    }

    /// To be called in main thread
    @MainActor func removeBookMark(newsItem: NewsFeedDataModel.NewsFeedItem) throws {
        try persistenceStore?.deleteBookedMarked(item: newsItem)

        // Update bookmarked list
        bookmarkedItems = try persistenceStore?.fetchBookMarkedItems().map { $0.newsFeedItem } ?? []
    }

    /// To be called in main thread
    @MainActor private func loadBookMarkedNewsFeedItems() throws {

        // Update bookmarked list
        bookmarkedItems = try persistenceStore?.fetchBookMarkedItems().map { $0.newsFeedItem } ?? []
    }
}
