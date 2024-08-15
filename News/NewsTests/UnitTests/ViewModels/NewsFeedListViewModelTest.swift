//
//  NewsFeedListViewModelTest.swift
//  SwiftDataTests
//
//  Created by Someshubhra Karmakar on 14/08/24.
//

import XCTest
import Combine
@testable import News

class NewsFeedListViewModelTest: XCTestCase {
    var moduleMockFactory: ModuleMockFactory!
    var sut: NewsFeedListViewModel!
    var bag = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        moduleMockFactory = ModuleMockFactory()
        
    }

    /// Given the the data manager as 3 news feed
    /// And one book marked item.
    ///
    /// Then we get 3 rows view model with the first one book marked on page load
    func testLoadNewsItemsWithBookMarking() {
        /// Given the the data manager as 3 news feed
        /// And one book marked item.
        
        let newsItemA = NewsFeedDataModel.NewsFeedItem(source: .init(id: "1", name: "Source 1"), author: "", title: "News A", description: "", url: "", imageUrl: "")
        let newsItemB = NewsFeedDataModel.NewsFeedItem(source: .init(id: "1", name: "Source 1"), author: "", title: "News B", description: "", url: "", imageUrl: "")
        let newsItemC = NewsFeedDataModel.NewsFeedItem(source: .init(id: "1", name: "Source 1"), author: "", title: "News C", description: "", url: "", imageUrl: "")
        let newsData = NewsFeedDataModel(newsFeeds: [newsItemA, newsItemB, newsItemC])
        moduleMockFactory.newsFeedDataManagerMock.newsFeedData = newsData
        moduleMockFactory.newsFeedDataManagerMock.bookmarkedItems = [newsItemA]

        /// When I create the view model
        /// Then we get 3 rows view model with the first one book marked
       
        let expect = XCTestExpectation(description: "Load news")
        
        sut = NewsFeedListViewModel(moduleFactory: moduleMockFactory)
        sut.$flowState
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { flowState in
            if flowState == .pageLoaded {
                // Then we get 3 rows view model with the first one book marked
                XCTAssertEqual(self.sut.rowViewModels.count, 3)
                XCTAssertEqual(self.sut.rowViewModels[0].isBookMarked, true)
                XCTAssertEqual(self.sut.rowViewModels[0].newsFeedItem.title, "News A")
                XCTAssertEqual(self.sut.rowViewModels[1].newsFeedItem.title, "News B")
                XCTAssertEqual(self.sut.rowViewModels[2].newsFeedItem.title, "News C")
                expect.fulfill()
            }
            
        }).store(in: &bag)
       wait(for: [expect], timeout: 3)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
