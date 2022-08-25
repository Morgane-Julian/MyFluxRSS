//
//  FirebaseFluxRepositoryTests.swift
//  MyFluxRSSTests
//
//  Created by Morgane Julian on 21/08/2022.
//

import XCTest
@testable import MyFluxRSS

final class FirebaseFluxRepositoryTests: XCTestCase {
    
    let flux = Flux()
    
    func testGetFluxMethod_WhenTheDBAnswerCorrect_ThenShouldGetTheDocument() {
        let sut : FluxRepository = FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.get(userId: "NyeVduglGkQAgldAgG5durdJAer2", callback: { result in
            XCTAssertTrue(result.first?.flux == "https://www.hackingwithswift.com/articles/rss")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetFluxMethod_WhenTheDBAnswerIncorrect_ThenShouldReturnAnError() {
        let sut : FluxRepository = FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: false))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.get(userId: "NyeVduglGkQAgldAgG5durdJAer2", callback: { result in
            XCTAssertTrue(result.isEmpty)
                expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testAddFluxMethod_WhenTheDBAnswerIsCorrect_ThenShouldAddTheDocumentInDB() {
        let sut : FluxRepository = FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.add(flux, callback: { result in
            XCTAssertTrue(result)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testAddFluxMethod_WhenTheDBAnswerIsIncorrect_ThenShouldReturnAnError() {
        let sut : FluxRepository = FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: false))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.add(flux, callback: { result in
            XCTAssertFalse(result)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDeleteFluxMethod_WhenTheDocumentIDIsCorrect_ThenShouldDeleteDocumentInDB() {
        let sut : FluxRepository = FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true))
        sut.remove(flux)
    }
    
    func testDeleteFluxMethod_WhenTheDocumentIDIsIncorrect_ThenShoulReturnAnError() {
        let sut : FluxRepository = FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: false))
        sut.remove(flux)
    }
}

