//
//  NewsFeedResponse.swift
//  News
//
//  Created by Someshubhra Karmakar on 10/08/24.
//

import Foundation

struct NewsFeedResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleResponse]

    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}

struct ArticleResponse: Codable {
    let source: ArticleSourceReponse?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?

    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
    }
}

struct ArticleSourceReponse: Codable {
    let id: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

// MARK: - Mappers

/// Map Response models to Business models
extension ArticleSourceReponse {
    var newsSourceDataModel: NewsFeedDataModel.NewsSource {
        NewsFeedDataModel.NewsSource(id: id ?? "", name: name ?? "")
    }
}

extension ArticleResponse {
    var newsItem: NewsFeedDataModel.NewsFeedItem {
        NewsFeedDataModel.NewsFeedItem(source: source?.newsSourceDataModel ?? .empty,
                                       author: author ?? "",
                                       title: title ?? "",
                                       description: description ?? "",
                                       url: url ?? "",
                                       imageUrl: urlToImage ?? "")
    }
}

extension NewsFeedResponse {
    var newsFeedDataModel: NewsFeedDataModel {
        let newsItems: [NewsFeedDataModel.NewsFeedItem] = articles.map { $0.newsItem }
        return NewsFeedDataModel(newsFeeds: newsItems)
    }
}
