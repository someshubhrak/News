//
//  NewsFeedDataModel.swift
//  News
//
//  Created by Someshubhra Karmakar on 11/08/24.
//

import Foundation

// Generic Data models to be used at UI and business logic

struct NewsFeedDataModel {
    var newsFeeds: [NewsFeedItem]
}

extension NewsFeedDataModel {
    struct NewsFeedItem: Hashable {
        let source: NewsSource
        let author: String
        let title: String
        let description: String
        let url: String
        let imageUrl: String
    }

    struct NewsSource: Hashable {
        let id: String
        let name: String

        static var empty: NewsSource {
            NewsSource(id: "", name: "")
        }
    }
}



