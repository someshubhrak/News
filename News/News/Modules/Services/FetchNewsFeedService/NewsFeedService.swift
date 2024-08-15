//
//  FetchNewsFeedService.swift
//  News
//
//  Created by Someshubhra Karmakar on 10/08/24.
//

import Foundation
typealias NewsFeedNetworkService = NetworkService<NewsFeedServiceRequestProvider,
                                                       NewsFeedResponse>

class NewsFeedService {
    func fetch(query: NewsFeedServiceQuery) async throws -> NewsFeedDataModel {
        let requestProvider = NewsFeedServiceRequestProvider(queryParams: query)
        let networkService = NewsFeedNetworkService(requestProvider: requestProvider)
        return try await networkService.execute().newsFeedDataModel
    }

    /// The search should have some query
    func fetch(searchTerm: String) async throws -> NewsFeedDataModel {
        let queryParam = NewsFeedServiceQuery(searchTerm: searchTerm)
        return try await fetch(query: queryParam)
    }
}



/// Request Builder
struct NewsFeedServiceQuery {
    var searchTerm: String?
}

struct NewsFeedServiceRequestProvider: NetworkRequestProviderType {
    let queryParams: NewsFeedServiceQuery

    var requestURL: URLRequest? {
        var urlString = NetworkUtility.baseNewsUrl + "/" + NetworkUtility.ServiceUrl.newsFeed.rawValue
        urlString = urlString + "?apiKey=" + NetworkUtility.key

        // create query String
        let searchTerm = queryParams.searchTerm ?? ""
        urlString = urlString + "&" + "q=" + searchTerm
        
        guard let url = URL(string: urlString) else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return URLRequest(url: url)
    }
}
