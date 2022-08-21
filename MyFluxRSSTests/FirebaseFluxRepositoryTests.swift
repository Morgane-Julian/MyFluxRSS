//
//  FirebaseFluxRepositoryTests.swift
//  MyFluxRSSTests
//
//  Created by Morgane Julian on 21/08/2022.
//

import XCTest
@testable import MyFluxRSS

final class FirebaseFluxRepositoryTests: XCTestCase {
    
    // MARK: - Helpers

    private class RepositoryTest: Repository {
        var path: String
        private let isSuccess: Bool
        typealias T = Flux
        
        
        init(path: String, isSuccess: Bool) {
            self.path = path
            self.isSuccess = isSuccess
        }
    
        func addDocument<T>(document: T, userID: String, callback: @escaping (Bool) -> Void) where T : Decodable, T : Encodable {
                callback(isSuccess)
        }
        
        func getDocument<T>(userID: String, callback: @escaping ([T]) -> Void) where T : Decodable, T : Encodable {
            if isSuccess {
            callback([Flux()] as! [T])
            } else {
                callback([])
            }
        }
        
        func deleteDocument(documentID: String, callback: @escaping (Bool) -> Void) {
            callback(isSuccess)
        }
    }
    
    //MARK: - Flux Repository Tests
    
    let flux = Flux()
    
    func testGetFluxMethod_WhenTheDBAnswerCorrect_ThenShouldGetTheDocument() {
        let sut : FluxRepository = FluxRepository(repository: RepositoryTest(path: "flux", isSuccess: true))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.get(callback: { result in
            XCTAssertTrue(result.first?.flux == "https://www.hackingwithswift.com/articles/rss")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetFluxMethod_WhenTheDBAnswerIncorrect_ThenShouldReturnAnError() {
        let sut : FluxRepository = FluxRepository(repository: RepositoryTest(path: "flux", isSuccess: false))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.get(callback: { result in
            XCTAssertTrue(result.isEmpty)
                expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testAddFluxMethod_WhenTheDBAnswerIsCorrect_ThenShouldAddTheDocumentInDB() {
        let sut : FluxRepository = FluxRepository(repository: RepositoryTest(path: "flux", isSuccess: true))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.add(flux, callback: { result in
            XCTAssertTrue(result)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testAddFluxMethod_WhenTheDBAnswerIsIncorrect_ThenShouldReturnAnError() {
        let sut : FluxRepository = FluxRepository(repository: RepositoryTest(path: "flux", isSuccess: false))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.add(flux, callback: { result in
            XCTAssertFalse(result)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDeleteFluxMethod_WhenTheDocumentIDIsCorrect_ThenShouldDeleteDocumentInDB() {
        let sut : FluxRepository = FluxRepository(repository: RepositoryTest(path: "flux", isSuccess: true))
        sut.remove(flux)
    }
    
    func testDeleteFluxMethod_WhenTheDocumentIDIsIncorrect_ThenShoulReturnAnError() {
        let sut : FluxRepository = FluxRepository(repository: RepositoryTest(path: "flux", isSuccess: false))
        sut.remove(flux)
    }
}

