//
//  NewsFeedsListView.swift
//  News
//
//  Created by Someshubhra Karmakar on 11/08/24.
//

import SwiftUI

struct NewsFeedsListView: View {
    @ObservedObject var viewModel: NewsFeedListViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(viewModel.rowViewModels) { rowItem in
                    NewsItemRowView(rowItemViewModel: rowItem)
                }
                .listStyle(PlainListStyle())
    
                if viewModel.flowState == .pageLoading {
                    ProgressView().controlSize(.extraLarge)
                }
            }
            .navigationTitle("News Feeds")
        }
        .searchable(text: $viewModel.searchText)
        .refreshable {
            viewModel.refreshNews()
        }
    }
}

