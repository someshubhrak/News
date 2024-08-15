//
//  NetworkService.swift
//  News
//
//  Created by Someshubhra Karmakar on 10/08/24.
//

import Foundation


/// Request provider
protocol NetworkRequestProviderType {
    var requestURL: URLRequest? { get }
}

/// Class for making service call at Network level
class NetworkService <RequestProvider: NetworkRequestProviderType,
                      ResponseModel: Codable> {
    private let session = URLSession.shared
    private let requestProvider: RequestProvider

    init(requestProvider: RequestProvider) {
        self.requestProvider = requestProvider
    }

    func execute() async throws -> ResponseModel {
        guard let urlRequest = requestProvider.requestURL else {
            throw NSError(domain: "", code: -1)
        }

        let (data, _) = try await session.data(for: urlRequest)
        let decoder = JSONDecoder()
        let response = try decoder.decode(ResponseModel.self, from: data)
        return response
    }
}
