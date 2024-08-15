//
//  NewsFeedDataManagerTests.swift
//  SwiftDataTests
//
//  Created by Someshubhra Karmakar on 15/08/24.
//

import XCTest
import Combine
@testable import News

class NewsFeedDataManagerTests: XCTestCase {
    
    var moduleMockFactory: ModuleMockFactory!
    var sut: NewsFeedDataManager!
    var bag = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        moduleMockFactory = ModuleMockFactory()
    }

    func testLoadBookMarkedFeeds() throws {
        moduleMockFactory.persistenceStoreMock.bookMarkedItems = [.init(title: "News A", itemDescription: "", author: "", url: "", sourceName: "", imageUrl: ""),
                                                                  .init(title: "News B", itemDescription: "", author: "", url: "", sourceName: "", imageUrl: "")]

        let expect = XCTestExpectation(description: "Load bookmarked items")
        sut = NewsFeedDataManager(moduleFactory: moduleMockFactory)
        sut.bookmarkedItemsPublished
            .sink(receiveValue: { _ in
                XCTAssertEqual(self.sut.bookmarkedItems.count, 2)
                XCTAssertEqual(self.sut.bookmarkedItems[0].title, "News A")
                XCTAssertEqual(self.sut.bookmarkedItems[1].title, "News B")
                print("Test Succeded")
                expect.fulfill()
            })
        .store(in: &bag)
        wait(for: [expect], timeout: 3)
    }
}
