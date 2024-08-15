//
//  NewsFeedListViewModel.swift
//  News
//
//  Created by Someshubhra Karmakar on 11/08/24.

import Foundation
import Combine
import SwiftUI

typealias NewsItemRowViewModel = NewsFeedListViewModel.RowItemViewModel

class NewsFeedListViewModel: ObservableObject {
    /// Different parts of the flow in this view model
    /// is represented by the FlowState enum
    enum FlowState {
        case initial
        case pageLoading
        case pageLoaded
        case pageLoadingError
    }

    @Published var flowState: FlowState = .initial

    /// Row view models
    private(set) var rowViewModels: [RowItemViewModel] = []
    @Published var searchText: String = "Current affairs"

    // For internal use and references
    private var bag = Set<AnyCancellable>()

    /// Business data model
    private var newsDataModel = NewsFeedDataModel(newsFeeds: [])

    private let moduleFactory: ModuleFactoryType
    private var newsFeedsManager: NewsFeedDataManagerType {
        moduleFactory.newsFeedDataManager
    }

    init(moduleFactory: ModuleFactoryType = ModuleFactory.shared) {
        self.moduleFactory = moduleFactory
        configureObservers()
    }

    func refreshNews() {
        loadNewsItemsTask()
    }

    private func configureObservers() {
        // Use some debouncing on search text
        $searchText
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink{ [weak self] _ in
                self?.loadNewsItemsTask()
            }
            .store(in: &bag)
    
        /// Listened to bookmarked changes
        newsFeedsManager.bookmarkedItemsPublished
            .sink{ [weak self] _ in
                self?.updateBookmarkedItems()
            }
            .store(in: &bag)
        
    }

    private func loadNewsItemsTask() {
        Task {
            // Empty all news first
            newsDataModel.newsFeeds = []
            await loadNewsFeeds()
        }
    }

    private func updateBookmarkedItems () {
        // get the bookmarked items
        let bookMarkedItems = newsFeedsManager.bookmarkedItems

        rowViewModels.forEach { rowModel in
            let isBookMarked = bookMarkedItems.contains { $0.title == rowModel.newsFeedItem.title }
            rowModel.isBookMarked = isBookMarked
        }
    }

    @MainActor private func loadNewsFeeds() async {
        do {
            flowState = .pageLoading

            // Get news feed and add it to the model
            let newNewsFeedData = try await newsFeedsManager.loadNewsFeeds(searchTerm: searchText)
            newsDataModel.newsFeeds.append(contentsOf: newNewsFeedData.newsFeeds)

            // get the bookmarked items
            let bookMarkedItems = newsFeedsManager.bookmarkedItems

            // Create row item view models
            // Put/Adjust indices as Ids
            rowViewModels = newsDataModel.newsFeeds.enumerated().compactMap { element in
                let newsItem = element.element
                let index = element.offset
    
                let isBookMarked = bookMarkedItems.contains { $0.title == newsItem.title }
                let row = RowItemViewModel(newsFeedItem: newsItem, id: index, isBookMarked: isBookMarked)
    
                row.bookMarkTapAction = { [weak self] in
                    self?.bookMarkAction(on: row)
                }
                return row
            }
            
            flowState = .pageLoaded
        }
        catch {
            flowState = .pageLoadingError
        }
    }

    @MainActor private func bookMarkAction(on row: RowItemViewModel) {
        // get the bookmarked items
        do {
            if row.isBookMarked {
                try newsFeedsManager.removeBookMark(newsItem: row.newsFeedItem)
                row.isBookMarked = false
            }
            else {
                try newsFeedsManager.bookMark(newsItem: row.newsFeedItem)
                row.isBookMarked = true
            }
        }
        catch {
            print(error)
        }
        
    }
}

// MARK: -  Row Item View Model
extension NewsFeedListViewModel {
    /// View model of row item
    class RowItemViewModel: Identifiable, ObservableObject {
        
        /// data for the view model
        let newsFeedItem: NewsFeedDataModel.NewsFeedItem

        /// Extra params for viewing
        /// This would basically an identifier index for view purpose
        var id: Int
        @Published var isBookMarked: Bool
 
        /// Downloaded and cached Image
        var image: Image?

        /// Action handlers
        var bookMarkTapAction:(() -> Void)?
    
        var tileLineText: String {
            "Title: " + newsFeedItem.title
        }

        var descriptionLineText: String {
            "Description: " + newsFeedItem.description
        }

        var sourceLineText: String {
            "Source: " + newsFeedItem.source.name
        }

        var bookMarkButtonTitle: String {
            isBookMarked == true ? "Remove bookmark" : "BookMark"
        }

        init(newsFeedItem: NewsFeedDataModel.NewsFeedItem, id: Int, isBookMarked: Bool, bookMarkTapAction: (() -> Void)? = nil) {
            self.newsFeedItem = newsFeedItem
            self.id = id
            self.isBookMarked = isBookMarked
            self.bookMarkTapAction = bookMarkTapAction
        }
    }
}
