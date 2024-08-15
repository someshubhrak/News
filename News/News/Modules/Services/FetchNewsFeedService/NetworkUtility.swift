//
//  NetworkUtility.swift
//  News
//
//  Created by Someshubhra Karmakar on 10/08/24.
//

import Foundation

class NetworkUtility {
    static let baseNewsUrl = "https://newsapi.org/v2"
    static let key = "112fea9e002c4555b4cd46b8c0e5e31c"

    enum ServiceUrl: String {
        case newsFeed = "everything"
    }
}
