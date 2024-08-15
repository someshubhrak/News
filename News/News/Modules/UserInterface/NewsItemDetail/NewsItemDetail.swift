//
//  NewsItemDetail.swift
//  News
//
//  Created by Someshubhra Karmakar on 14/08/24.
//

import Foundation

class NewsItemDetailViewModel {
    let newsItem: NewsFeedDataModel.NewsFeedItem

    init(newsItem: NewsFeedDataModel.NewsFeedItem) {
        self.newsItem = newsItem
    }
}
