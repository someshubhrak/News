//
//  NewsFeedServiceMock.swift
//  NewsTests
//
//  Created by Someshubhra Karmakar on 15/08/24.
//

import Foundation
@testable import News

class NewsFeedServiceMock: NewsFeedServiceType {
    var dataModel = News.NewsFeedDataModel(newsFeeds: [])
    func fetch(query: News.NewsFeedServiceQuery) async throws -> News.NewsFeedDataModel {
        dataModel
    }
    
    func fetch(searchTerm: String) async throws -> News.NewsFeedDataModel {
        dataModel
    }
}
