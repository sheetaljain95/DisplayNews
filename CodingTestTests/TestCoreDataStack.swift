//
//  TestCoreDataStack.swift
//  CodingTestTests
//
//  Created by Sheetal Jain on 22/09/21.
//
import CoreData
import XCTest
import CodingTest
@testable import CodingTest

class TestCoreDataStack: XCTestCase {
    var coreData = CoreDataModel()
    var apiService = APIService()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testApiResponse() {
        var articleResponse: [NewsCoreData]!
        let articleExpectation = expectation(description: "Articles")
        self.apiService.apiToGetNewsData { (newsData) in
            articleResponse = newsData
            articleExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 10) { (error) in
            XCTAssertNotNil(articleResponse)
        }
    }
    
    func testCoreDataAndApiResponse() {
        coreData.deleteData()
        let testData = Article(source: nil, author: "SamMobile", title: "Samsung’s Hand Wash app now available for Wear OS-based Galaxy Watch 4 - SamMobile", articleDescription: "Samsung’s Hand Wash app now available for Wear OS-based Galaxy Watch 4 - SamMobile", url: "https://www.sammobile.com/news/samsung-hand-wash-app-wear-os-galaxy-watch-4/", urlToImage: "https://www.sammobile.com/wp-content/uploads/2021/08/Galaxy-Watch-4-review-8-720x480.jpg", publishedAt: "2021-09-21T06:45:00Z", content: "Samsung’s Hand Wash app now available for Wear OS-based Galaxy Watch 4 - SamMobile")
        coreData.createData(news: [testData])
        let dataFetched = coreData.retreiveData()
        XCTAssertNotNil(dataFetched, "Data should not be nil")
        XCTAssertEqual(testData.author, dataFetched.first?.author)
        XCTAssertEqual(testData.title, dataFetched.first?.title)
        XCTAssertEqual(testData.articleDescription, dataFetched.first?.articleDescription)
        XCTAssertEqual(testData.url, dataFetched.first?.url)
        XCTAssertEqual(testData.urlToImage, dataFetched.first?.urlToImage)
        XCTAssertEqual(testData.publishedAt, dataFetched.first?.publishedAt)
        XCTAssertEqual(testData.content, dataFetched.first?.content)
        XCTAssertNotNil(dataFetched.first, "Data should not be nil")
        coreData.deleteData()
    }
}
