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
        sut.userMail = "morgane.julian@gmail.com"
        sut.password = "password"
        sut.connect(callback: { success in
            XCTAssertTrue(success)
        })
    }
    
    func testConnectUserWhenUserHaveNoEmailAndPasswordThenShouldReturnError() {
        let sut = AuthViewModel(authService: AuthService(auth: FakeAuth(false, error: .error)))
        sut.connect(callback: { success in
            XCTAssertFalse(success)
        })
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
        //        sut.user = Usertest()
        sut.inscription()
    }
    
    func testInscriptionMethodWhenPassIncorrectUserInformationThenShouldReturnError() {
        
    }
    
    //MARK: - NewsFeedViewModelTests
    func testAddMethodWhenPassCorrectUserIDThenShoudlReturnSuccess() {
        let sut = NewsFeedViewModel(articleRepository: ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: true)))
        sut.add(article, userID: "NyeVduglGkQAgldAgG5durdJAer2", callback: { success in
            XCTAssertTrue(success)
        })
    }
    
    func testAddMethodWhenPassIncorrectUserIDThenShoudlReturnError() {
        let sut = NewsFeedViewModel(articleRepository: ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: false)))
        sut.add(article, userID: "BadUID", callback: { success in
            XCTAssertFalse(success)
        })
    }
    
    func testRefreshArticleFeedMethodWhenPassIncorrectArticleThenShoudlReturnError() {
        let sut = NewsFeedViewModel(articleRepository: ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: true)))
        sut.refreshArticleFeed(userId: "NyeVduglGkQAgldAgG5durdJAer2", callback: { success in
            XCTAssertFalse(success)
        })
    }
    
    //MARK: - ParametersViewModelTests
    func testAddNewFluxMethodWhenPassCorrectDataThenShouldReturnSucces() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true)), authService: AuthService(auth: FakeAuth(true, error: .noError)))
        sut.urlString = "https://www.apple.com/articles/rss"
        sut.addNewFlux(userID: "NyeVduglGkQAgldAgG5durdJAer2")
    }
    
    func testAddNewFluxMethodWhenPassFluxAlreadyInDBDataThenShouldReturnError() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true)), authService: AuthService(auth: FakeAuth(false, error: .error)))
        sut.urlString = "https://www.hackingwithswift.com/articles/rss"
        sut.addNewFlux(userID: "NyeVduglGkQAgldAgG5durdJAer2")
    }
    
    func testAddNewFluxMethodWhenPassInorrectDataThenShouldReturnError() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: false)), authService: AuthService(auth: FakeAuth(false, error: .error)))
        sut.urlString = " "
        sut.addNewFlux(userID: "NyeVduglGkQAgldAgG5durdJAer2")
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
        sut.reauthenticate(email: "correctEmail", password: "correctPassword", callback: { success in
            XCTAssertTrue(success)
        })
    }
    
    func testReauthenticateMethodWhenPassInorrectDataThenShouldReturnError() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: false)), authService: AuthService(auth: FakeAuth(false, error: .error)))
        sut.reauthenticate(email: "incorrectEmail", password: "incorrectPassword", callback: { success in
            XCTAssertFalse(success)
        })
    }
    
    func testDisconnectMethodWhenPassCorrectDataThenShouldReturnSucces() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true)), authService: AuthService(auth: FakeAuth(true, error: .noError)))
        sut.disconnect(callback: { success in
            XCTAssertTrue(success)
        })
    }
    
    func testDisconnectMethodWhenPassInorrectDataThenShouldReturnError() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: false)), authService: AuthService(auth: FakeAuth(false, error: .error)))
        sut.disconnect(callback: { success in
            XCTAssertFalse(success)
        })
    }
    
    func testChangePasswordMethodWhenPassCorrectDataThenShouldReturnSucces() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true)), authService: AuthService(auth: FakeAuth(true, error: .noError)))
        sut.changePassword(password: "correctPassword", callback: { success in
            XCTAssertTrue(success)
        })
    }
    
    func testChangePasswordMethodWhenPassInorrectDataThenShouldReturnError() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: false)), authService: AuthService(auth: FakeAuth(false, error: .error)))
        sut.changePassword(password: "correctPassword", callback: { success in
            XCTAssertFalse(success)
        })
    }
    
    func testDeleteAccountMethodWhenPassCorrectDataThenShouldReturnSucces() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: true)), authService: AuthService(auth: FakeAuth(true, error: .noError)))
        sut.deleteAcount(callback: { success in
            XCTAssertTrue(success)
        })
    }
    
    func testDeleteAccountMethodWhenPassInorrectDataThenShouldReturnError() {
        let sut = ParametersViewModel(fluxRepository: FluxRepository(repository: FakeFluxRepository(path: "flux", isSuccess: false)), authService: AuthService(auth: FakeAuth(false, error: .error)))
        sut.deleteAcount(callback: { success in
            XCTAssertFalse(success)
        })
    }
    
    //MARK: - BookmarkViewModelTests
    func testGetFavArticleMethod_WhenPassCorrectData_ThenShouldReturnSuccess() {
        let sut = BookmarkViewModel(articleRepository: ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: true)))
        sut.getFavArticle()
    }
    
    func testGetFavArticleMethod_WhenPassIncorrectData_ThenShouldReturnError() {
        let sut = BookmarkViewModel(articleRepository: ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: false)))
        sut.getFavArticle()
    }
    
    func testRemoveArticleMethod_WhenPassCorrectData_ThenShouldReturnSuccess() {
        let sut = BookmarkViewModel(articleRepository: ArticleRepository(repository: FakeArticleRepository(path: "articles", isSuccess: true)))
        self.article.id = "0"
        sut.bookmarks.append(self.article)
        sut.removeArticle(indexSet: [0])
        XCTAssertTrue(sut.bookmarks.isEmpty)
    }
}
