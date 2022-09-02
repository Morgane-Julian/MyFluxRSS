//
//  FirebaseRepositoryTest.swift
//  MyFluxRSSTests
//
//  Created by Morgane Julian on 19/08/2022.
//

import XCTest
@testable import MyFluxRSS

final class FirebaseArticleRepositoryTests: XCTestCase {
    
    // MARK: - Article Repository Tests
    var article = Article()
    
    func testGetArticleMethod_WhenTheUIDIsCorrect_ThenShouldGetTheDocument() {
        let sut : ArticleRepository = ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: true))
        let uid: String = "NyeVduglGkQAgldAgG5durdJAer2"
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.get(userID: uid, callback: { (result: [Article]) in
            XCTAssertTrue(result.first?.title == "WWDC22: Wrap up and recommended talks")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetArticleMethod_WhenTheUIDIsIncorrect_ThenShouldReturnAnError() {
        let sut : ArticleRepository = ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: false))
        let uid: String = "NyeVduglGkQAgld"
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.get(userID: uid, callback: { (result: [Article]) in
            XCTAssertTrue(result == [])
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testAddArticleMethod_WhenTheUIDIsCorrect_ThenShouldAddTheDocumentInDB() {
        let sut : ArticleRepository = ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: true))
        let uid: String = "NyeVduglGkQAgldAgG5durdJAer2"
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.add(article, userID: uid, callback: { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testAddArticleMethod_WhenTheUIDIsIncorrect_ThenShouldReturnAnError() {
        let sut : ArticleRepository = ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: false))
        let uid: String = "Incorrect UID"
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.add(article, userID: uid, callback: { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDeleteArticleMethod_WhenTheDocumentIDIsCorrect_ThenShouldDeleteDocumentInDB() {
        let sut : ArticleRepository = ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: true))
        article.id = "fjdlJJKN57gbjk"
        if article.id != nil {
            let success = sut.remove(article)
            XCTAssertTrue(success)
        }
    }
    
    func testDeleteArticleMethod_WhenTheDocumentIDIsIncorrect_ThenShoulReturnAnError() {
        let sut : ArticleRepository = ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: false))
        if article.id == nil {
            let success = sut.remove(article)
            XCTAssertFalse(success)
        }
    }
    
}
