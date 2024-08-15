//
//  BookMarkedNewsListViewModel.swift
//  News
//
//  Created by Someshubhra Karmakar on 12/08/24.
//

import Foundation
import Combine

class BookMarkedNewsListViewModel: ObservableObject {

    /// Row view models
    @Published var rowViewModels: [NewsItemRowViewModel] = []
    
    // For internal use and references
    private var bag = Set<AnyCancellable>()

    /// Business datamodel
    private var bookMarkedItems: [NewsFeedDataModel.NewsFeedItem] = []

    private let moduleFactory: ModuleFactoryType
    private var newsFeedsManager: NewsFeedDataManagerType {
        moduleFactory.newsFeedDataManager
    }
    
    init(moduleFactory: ModuleFactoryType = ModuleFactory.shared) {
        self.moduleFactory = moduleFactory
        configreObservers()
    }
    
    private func configreObservers() {
        newsFeedsManager.bookmarkedItemsPublished
            .sink{ [weak self] _ in
                self?.updateRowModels()
            }
            .store(in: &bag)
    }
    
    
    func updateRowModels() {
        // get the bookmarked items
        bookMarkedItems = newsFeedsManager.bookmarkedItems
        
        // Create row item view models
        // Put/Adjust indices as Ids for List viewing
        rowViewModels = bookMarkedItems.enumerated().compactMap { item in
            let row = NewsItemRowViewModel(newsFeedItem: item.element, id: item.offset, isBookMarked: true)
            row.bookMarkTapAction = { [weak self]  in
                self?.bookMarkAction(on: row)
            }
            return row
        }
    }
    
    private func bookMarkAction(on row: NewsItemRowViewModel) {
        Task { @MainActor in
            // get the bookmarked items
            if row.isBookMarked {
                try? newsFeedsManager.removeBookMark(newsItem: row.newsFeedItem)
                row.isBookMarked = false
            }
        }
    }
}
