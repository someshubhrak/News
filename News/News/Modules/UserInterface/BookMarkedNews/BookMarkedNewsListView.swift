//
//  BookMarkedNewsListView.swift
//  News
//
//  Created by Someshubhra Karmakar on 12/08/24.
//

import SwiftUI

struct BookMarkedNewsListView: View {
    @ObservedObject var viewModel: BookMarkedNewsListViewModel

    var body: some View {
        NavigationStack {
            List(viewModel.rowViewModels) { rowItem in
                NewsItemRowView(rowItemViewModel: rowItem)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Bookmarked Feeds")
        }
    }
}
