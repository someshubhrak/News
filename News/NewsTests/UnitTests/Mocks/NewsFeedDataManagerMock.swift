//
//  NewsFeedDataManagerMock.swift
//  SwiftDataTests
//
//  Created by Someshubhra Karmakar on 14/08/24.
//

import Foundation
import Combine
@testable import News

class NewsFeedDataManagerMock: NewsFeedDataManagerType {
    var bookmarkedItemsPublished = PassthroughSubject<[NewsFeedDataModel.NewsFeedItem], Never>()
    var bookmarkedItems: [NewsFeedDataModel.NewsFeedItem] = [] {
        didSet {
            bookmarkedItemsPublished.send(bookmarkedItems)
        }
    }
    var newsFeedData = NewsFeedDataModel(newsFeeds: [])
    
    func loadNewsFeeds(searchTerm: String) async throws -> NewsFeedDataModel { newsFeedData }
    
    func bookMark(newsItem: NewsFeedDataModel.NewsFeedItem) throws {}
    
    func removeBookMark(newsItem: NewsFeedDataModel.NewsFeedItem) throws {}
}
