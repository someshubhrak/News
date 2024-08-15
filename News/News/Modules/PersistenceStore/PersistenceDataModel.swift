//
//  PersistenceDataModel.swift
//  News
//
//  Created by Someshubhra Karmakar on 11/08/24.
//

import Foundation
import SwiftData

/// Persistence Data Model are separated domain/business model
/// This is to keep a separation bases on the type of persistence used.


extension PersistenceDataStore {
    @Model
    class BookmarkedNewsItem {
        @Attribute(.unique) var title: String
        var itemDescription: String
        var author: String
        var url: String
        var sourceName: String
        var imageUrl: String
        

        init(title: String,
             itemDescription: String,
             author: String,
             url: String,
             sourceName: String,
             imageUrl: String) {

            self.title = title
            self.itemDescription = itemDescription
            self.author = author
            self.url = url
            self.sourceName = sourceName
            self.imageUrl = imageUrl
        }
    }
}

// MARK: - Mapper
extension PersistenceDataStore.BookmarkedNewsItem {
    var newsFeedItem: NewsFeedDataModel.NewsFeedItem {
        NewsFeedDataModel.NewsFeedItem(source: .init(id: "", name: sourceName),
                                       author: author,
                                       title: title,
                                       description: itemDescription,
                                       url: url,
                                       imageUrl: imageUrl)
    }
}

// MARK: - Mapper
extension NewsFeedDataModel.NewsFeedItem {
    var bookMarkedFeedItem: PersistenceDataStore.BookmarkedNewsItem {
        PersistenceDataStore.BookmarkedNewsItem(title: title,
                                                itemDescription: description,
                                                author: author,
                                                url: url,
                                                sourceName: source.name,
                                                imageUrl: imageUrl)
    }
}


