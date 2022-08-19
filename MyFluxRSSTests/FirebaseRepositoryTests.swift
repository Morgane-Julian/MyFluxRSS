//
//  FirebaseRepositoryTest.swift
//  MyFluxRSSTests
//
//  Created by Morgane Julian on 19/08/2022.
//

import XCTest
@testable import MyFluxRSS

final class FirebaseRepositoryTests: XCTestCase {
    
    // MARK: - Helpers

    private class RepositoryTest: Repository {
        var path: String
        private let isSuccess: Bool
        
        
        init(path: String, isSuccess: Bool) {
            self.path = path
            self.isSuccess = isSuccess
        }
    
        func addDocument<T>(document: T, userID: String, callback: @escaping (Bool) -> Void) where T : Decodable, T : Encodable {
            callback(isSuccess)
        }
        
        func getDocument<T>(userID: String, callback: @escaping ([T]) -> Void) where T : Decodable, T : Encodable {
           callback([])
        }
        
        func deleteDocument(documentID: String, callback: @escaping (Bool) -> Void) {
            callback(isSuccess)
        }
    }

    // MARK: - Repository Tests
    
    let article = ArticleTest()
    var articles = [ArticleTest]()

    func testAddDocumentMethod_WhenTheUIDIsCorrect_ThenShouldAddTheDocumentInDB() {
        let sut = RepositoryTest(path: "articles", isSuccess: true)
        let uid: String = "NyeVduglGkQAgldAgG5durdJAer2"
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.addDocument(document: article, userID: uid, callback: { result in
            XCTAssertTrue(result == true)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testAddDocumentMethod_WhenTheUIDIsIncorrect_ThenShouldReturnAnError() {
        let sut = RepositoryTest(path: "article", isSuccess: false)
        let uid: String = "NyeVduglGkQAgldAgG5durdJAer2"
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.addDocument(document: article, userID: uid, callback: { result in
            XCTAssertTrue(result == false)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDeleteDocumentMethod_WhenTheDocumentIDIsCorrect_ThenShouldDeleteDocumentInDB() {
        let sut = RepositoryTest(path: "article", isSuccess: true)
        let documentID: String = article.id
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.deleteDocument(documentID: documentID, callback: { result in
            XCTAssertTrue(result == true)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDeleteDocumentMethod_WhenTheDocumentIDIsIncorrect_ThenShoulReturnAnError() {
        let sut = RepositoryTest(path: "article", isSuccess: false)
        let documentID: String = "badArticleID"
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.deleteDocument(documentID: documentID, callback: { result in
            XCTAssertTrue(result == false)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
}
