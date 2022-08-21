//
//  FirebaseRepositoryTest.swift
//  MyFluxRSSTests
//
//  Created by Morgane Julian on 19/08/2022.
//

import XCTest
@testable import MyFluxRSS

final class FirebaseArticleRepositoryTests: XCTestCase {
    
    // MARK: - Helpers
    
    private class RepositoryTest: Repository {
        var path: String
        private let isSuccess: Bool
        typealias T = Article
        
        
        init(path: String, isSuccess: Bool) {
            self.path = path
            self.isSuccess = isSuccess
        }
        
        func addDocument<T>(document: T, userID: String, callback: @escaping (Bool) -> Void) where T : Decodable, T : Encodable {
            callback(isSuccess)
        }
        
        func getDocument<T>(userID: String, callback: @escaping ([T]) -> Void) where T : Decodable, T : Encodable {
            if userID == "NyeVduglGkQAgldAgG5durdJAer2" {
                callback([Article()] as! [T])
            } else {
                callback([])
            }
        }
        
        func deleteDocument(documentID: String, callback: @escaping (Bool) -> Void) {
            callback(isSuccess)
        }
    }
    
    // MARK: - Article Repository Tests
    let article = Article()
    
    func testGetArticleMethod_WhenTheUIDIsCorrect_ThenShouldGetTheDocument() {
        let sut : ArticleRepository = ArticleRepository(repository: RepositoryTest(path: "articles", isSuccess: true))
        let uid: String = "NyeVduglGkQAgldAgG5durdJAer2"
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.get(userID: uid, callback: { (result: [Article]) in
            XCTAssertTrue(result.first?.title == "WWDC22: Wrap up and recommended talks")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetArticleMethod_WhenTheUIDIsIncorrect_ThenShouldReturnAnError() {
        let sut : ArticleRepository = ArticleRepository(repository: RepositoryTest(path: "articles", isSuccess: false))
        let uid: String = "NyeVduglGkQAgld"
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.get(userID: uid, callback: { (result: [Article]) in
            XCTAssertTrue(result == [])
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testAddArticleMethod_WhenTheUIDIsCorrect_ThenShouldAddTheDocumentInDB() {
        let sut : ArticleRepository = ArticleRepository(repository: RepositoryTest(path: "articles", isSuccess: true))
        let uid: String = "NyeVduglGkQAgldAgG5durdJAer2"
        sut.add(article, userID: uid)
    }
    
    func testAddArticleMethod_WhenTheUIDIsIncorrect_ThenShouldReturnAnError() {
        let sut : ArticleRepository = ArticleRepository(repository: RepositoryTest(path: "articles", isSuccess: false))
        let uid: String = "NyeVduglGkQAgldAgG5durdJAer2"
        sut.add(article, userID: uid)
    }
    
    func testDeleteArticleMethod_WhenTheDocumentIDIsCorrect_ThenShouldDeleteDocumentInDB() {
        let sut : ArticleRepository = ArticleRepository(repository: RepositoryTest(path: "articles", isSuccess: true))
        if article.id != nil {
            let success = sut.remove(article)
            XCTAssertTrue(success)
        }
    }
    
    func testDeleteArticleMethod_WhenTheDocumentIDIsIncorrect_ThenShoulReturnAnError() {
        let sut : ArticleRepository = ArticleRepository(repository: RepositoryTest(path: "articles", isSuccess: false))
        if article.id != nil {
            let success = sut.remove(article)
            XCTAssertFalse(success)
        }
    }
    
}
