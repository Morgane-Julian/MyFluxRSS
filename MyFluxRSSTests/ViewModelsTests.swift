//
//  ViewModelsTests.swift
//  MyFluxRSSTests
//
//  Created by Morgane Julian on 25/08/2022.
//
import Foundation
@testable import MyFluxRSS
import XCTest

final class ViewModelsTests: XCTestCase {
    
    private var article = Article()
    private var flux = Flux()
    
    
    //MARK: - AuthViewModelTests
    func testConnectUserWhenUserEnterCorrectEmailAndPasswordThenShouldReturnSuccess() {
        let sut = AuthViewModel(authService: AuthService(auth: FakeAuth(true, error: .noError)))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.userMail = "morgane.julian@gmail.com"
        sut.password = "password"
        sut.connect(callback: { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testConnectUserWhenUserHaveNoEmailAndPasswordThenShouldReturnError() {
        let sut = AuthViewModel(authService: AuthService(auth: FakeAuth(false, error: .error)))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.connect(callback: { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testIsUserAlreadyLogMethodWhenPassAUserIDThenShouldReturnSuccess() {
        let sut = AuthViewModel(authService: AuthService(auth: FakeAuth(true, error: .noError)))
        let success = sut.isUserAlreadyLog()
        XCTAssertTrue(success)
    }
    
    func testIsUserAlreadyLogMethodWhenPassNoUserIDThenShouldReturnError() {
        let sut = AuthViewModel(authService: AuthService(auth: FakeAuth(false, error: .error)))
        let success = sut.isUserAlreadyLog()
        XCTAssertFalse(success)
    }
    
    //MARK: - RegisterViewModelTests
    
    func testInscriptionMethodWhenPassUserInformationThenShouldReturnSuccess() {
        let sut = RegisterViewModel(authService: AuthService(auth: FakeAuth(true, error: .noError)))
        sut.inscription()
        XCTAssertTrue(sut.isSignedIn)
    }
    
    func testInscriptionMethodWhenPassIncorrectUserInformationThenShouldReturnError() {
        let sut = RegisterViewModel(authService: AuthService(auth: FakeAuth(false, error: .error)))
        sut.inscription()
        XCTAssertFalse(sut.isSignedIn)
    }
    
    //MARK: - NewsFeedViewModelTests
    func testAddMethodWhenPassCorrectUserIDThenShoudlReturnSuccess() {
        let sut = NewsFeedViewModel(articleRepository: ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: true)))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.add(article, userID: "NyeVduglGkQAgldAgG5durdJAer2", callback: { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testAddMethodWhenPassIncorrectUserIDThenShoudlReturnError() {
        let sut = NewsFeedViewModel(articleRepository: ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: false)))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.add(article, userID: "BadUID", callback: { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testRefreshArticleFeedMethodWhenPassIncorrectArticleThenShoudlReturnError() {
        let sut = NewsFeedViewModel(articleRepository: ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: true)))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.refreshArticleFeed(userId: "NyeVduglGkQAgldAgG5durdJAer2", callback: { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    //MARK: - BookmarkViewModelTests
    func testGetFavArticleMethod_WhenPassCorrectData_ThenShouldReturnSuccess() {
        let sut = BookmarkViewModel(articleRepository: ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: true)))
        sut.getFavArticle()
    }
    
    func testGetFavArticleMethod_WhenPassIncorrectData_ThenShouldReturnError() {
        let sut = BookmarkViewModel(articleRepository: ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: false)))
        sut.getFavArticle()
        XCTAssertTrue(sut.bookmarks.isEmpty)
    }
    
    func testRemoveArticleMethod_WhenPassCorrectData_ThenShouldReturnSuccess() {
        let sut = BookmarkViewModel(articleRepository: ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: true)))
        self.article.id = "0"
        sut.bookmarks.append(self.article)
        sut.removeArticle(indexSet: [0])
        XCTAssertTrue(sut.bookmarks.isEmpty)
    }
    
    //MARK: - ParametersViewModelTests
    func testAddNewFluxMethodWhenPassCorrectDataThenShouldReturnSucces() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true)), authService: AuthService(auth: FakeAuth(true, error: .noError)))
        sut.urlString = "https://www.apple.com/articles/rss"
        sut.addNewFlux(userID: "NyeVduglGkQAgldAgG5durdJAer2")
        XCTAssertTrue(sut.myFlux.contains(where: {$0.flux == "https://www.apple.com/articles/rss"}))
    }
    
    func testAddNewFluxMethodWhenPassFluxAlreadyInDBThenShouldReturnError() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true)), authService: AuthService(auth: FakeAuth(false, error: .error)))
        sut.myFlux.append(Flux())
        sut.urlString = "https://www.hackingwithswift.com/articles/rss"
        sut.addNewFlux(userID: "NyeVduglGkQAgldAgG5durdJAer2")
        XCTAssertTrue(sut.myFlux.count == 1)
    }
    
    func testAddNewFluxMethodWhenPassInorrectDataThenShouldReturnError() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: false)), authService: AuthService(auth: FakeAuth(false, error: .error)))
        sut.urlString = " "
        sut.addNewFlux(userID: "NyeVduglGkQAgldAgG5durdJAer2")
        XCTAssertTrue(sut.myFlux.isEmpty)
    }
    
    func testGetFluxMethodWhenPassCorrectDataThenShouldReturnSucces() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true)), authService: AuthService(auth: FakeAuth(true, error: .noError)))
        sut.getFlux(userID: "NyeVduglGkQAgldAgG5durdJAer2")
        XCTAssertFalse(sut.myFlux.isEmpty)
    }
    
    func testGetFluxMethodWhenPassInorrectDataThenShouldReturnError() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: false)), authService: AuthService(auth: FakeAuth(false, error: .error)))
        sut.myFlux.removeAll()
        sut.getFlux(userID: "NyeVduglGkQAgldAgG5durdJAer2")
        XCTAssertTrue(sut.myFlux.isEmpty)
    }
    
    func testDeleteNewFluxMethodWhenPassCorrectDataThenShouldReturnSucces() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true)), authService: AuthService(auth: FakeAuth(true, error: .noError)))
        self.flux.id = "0"
        sut.myFlux.append(self.flux)
        sut.delete(at: [0])
        XCTAssertTrue(sut.myFlux.isEmpty)
    }
    
    func testReauthenticateMethodWhenPassCorrectDataThenShouldReturnSucces() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true)), authService: AuthService(auth: FakeAuth(true, error: .noError)))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.reauthenticate(email: "correctEmail", password: "correctPassword", callback: { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testReauthenticateMethodWhenPassInorrectDataThenShouldReturnError() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: false)), authService: AuthService(auth: FakeAuth(false, error: .error)))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.reauthenticate(email: "incorrectEmail", password: "incorrectPassword", callback: { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDisconnectMethodWhenPassCorrectDataThenShouldReturnSucces() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true)), authService: AuthService(auth: FakeAuth(true, error: .noError)))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.disconnect(callback: { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDisconnectMethodWhenPassInorrectDataThenShouldReturnError() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: false)), authService: AuthService(auth: FakeAuth(false, error: .error)))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.disconnect(callback: { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangePasswordMethodWhenPassCorrectDataThenShouldReturnSucces() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true)), authService: AuthService(auth: FakeAuth(true, error: .noError)))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.changePassword(password: "correctPassword", callback: { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangePasswordMethodWhenPassInorrectDataThenShouldReturnError() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: false)), authService: AuthService(auth: FakeAuth(false, error: .error)))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.changePassword(password: "correctPassword", callback: { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDeleteAccountMethodWhenPassCorrectDataThenShouldReturnSucces() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true)), authService: AuthService(auth: FakeAuth(true, error: .noError)))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.deleteAcount(callback: { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDeleteAccountMethodWhenPassInorrectDataThenShouldReturnError() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: false)), authService: AuthService(auth: FakeAuth(false, error: .error)))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.deleteAcount(callback: { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
}
