//
//  ContentView.swift
//  SwiftData
//
//  Created by Someshubhra Karmakar on 10/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsFeedsListView(viewModel: NewsFeedListViewModel())
                .tabItem {
                    Text("News").font(.title)
            }
            BookMarkedNewsListView(viewModel: BookMarkedNewsListViewModel())  .tabItem {
                Text("Bookmark")
                    .font(.title)
            }
        }
    }
}

