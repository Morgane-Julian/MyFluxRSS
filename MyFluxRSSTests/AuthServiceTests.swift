//
//  AuthServiceTests.swift
//  MyFluxRSSTests
//
//  Created by Morgane Julian on 12/08/2022.
//

import XCTest
@testable import MyFluxRSS

final class AuthServiceTests: XCTestCase {
    
    
    // MARK: - Tests
    
    func testCurrentUID_WhenTheUserIsConnected_ThenShouldReturnAValue() {
        let sut: AuthService = AuthService(auth: FakeAuth(true, error: .noError))
        let expectedUID: String = "NyeVduglGkQAgldAgG5durdJAer2"
        XCTAssertTrue(sut.currentUID! == expectedUID)
    }
    
    func testCurrentUID_WhenTheUserIsDisconnected_ThenShouldReturnANilValue() {
        let sut: AuthService = AuthService(auth: FakeAuth(false, error: .error))
        let expectedUID: String? = nil
        XCTAssertTrue(sut.currentUID == expectedUID)
    }
    
    func testSignInMethod_WhenTheUserEnterCorrectData_ThenShouldConnectTheUser() {
        let sut: AuthService = AuthService(auth: FakeAuth(true, error: .noError))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.connect(userMail: "CorrectMail", password: "CorrectPassword", callback: { isSuccess in
            XCTAssertTrue(isSuccess == true)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testSignInMethod_WhenTheUserEnterIncorrectData_ThenShouldNotConnectTheUser() {
        let sut: AuthService = AuthService(auth: FakeAuth(false, error: .error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.connect(userMail: "IncorrectMail", password: "IncorrectPassword", callback: { isSuccess in
            XCTAssertTrue(isSuccess == false)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testSignUpMethod_WhenTheUserEnterCorrectData_ThenShouldCreateTheUser() {
        let sut: AuthService = AuthService(auth: FakeAuth(true, error: .noError))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.inscription(userMail: "Email", userPassword: "Password", callback: { isSuccess in
            XCTAssertTrue(isSuccess == true)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testSignUpMethod_WhenTheUserEnterIncorrectData_ThenShouldNotCreateTheUser() {
        let sut: AuthService = AuthService(auth: FakeAuth(false, error: .error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.inscription(userMail: "Email", userPassword: "Password", callback: { isSuccess in
            XCTAssertTrue(isSuccess == false)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testSignOutMethod_WhenTheUserWantsToBeDisconnected_ThenTheUserShouldBeDisconnected() {
        let sut: AuthService = AuthService(auth: FakeAuth(true, error: .noError))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.disconnect(callback: { isSuccess in
            XCTAssertTrue(isSuccess == true)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testSignOutMethod_WhenTheUserWantsToBeDisconnected_ThenTheUserShouldNotBeDisconnected() {
        let sut: AuthService = AuthService(auth: FakeAuth(false, error: .error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.disconnect(callback: { isSuccess in
            XCTAssertTrue(isSuccess == false)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testReauthenticateMethod_WhenTheUserNeedToBeReauthenticate_ThenTheUserShouldBeReauthenticate() {
        let sut: AuthService = AuthService(auth: FakeAuth(true, error: .noError))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.reauthenticate(email: "Email", password: "Password", callback: { isSuccess in
            XCTAssertTrue(isSuccess == true)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testReauthenticateMethod_WhenTheUserNeedToBeReauthenticate_ThenTheUserShouldNotBeReauthenticate() {
        let sut: AuthService = AuthService(auth: FakeAuth(false, error: .error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.reauthenticate(email: "Email", password: "WrongPassword", callback: { isSuccess in
            XCTAssertTrue(isSuccess == false)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangePasswordMethod_WhenTheUserWantToChangePassword_ThenTheUserShouldSaveNewPassword() {
        let sut: AuthService = AuthService(auth: FakeAuth(true, error: .noError))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.changePassword(password: "NewPassword", callback: { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangePasswordMethod_WhenTheUserWantToChangePassword_ThenTheUserShouldNotSaveNewPassword() {
        let sut: AuthService = AuthService(auth: FakeAuth(false, error: .error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.changePassword(password: "NewPassword", callback: { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDeleteAccountMethod_WhenTheUserWantDeleteAccount_ThenAccountIsDeleted() {
        let sut: AuthService = AuthService(auth: FakeAuth(true, error: .noError))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.deleteAcount(callback: { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDeleteAccountMethod_WhenTheUserWantDeleteAccount_ThenAccountIsNotDeleted() {
        let sut: AuthService = AuthService(auth: FakeAuth(false, error: .error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.deleteAcount(callback: { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testIsUserConnectedMethod_WhenTheUserIsLog_ThenShouldReturnSuccess() {
        let sut: AuthService = AuthService(auth: FakeAuth(true, error: .noError))
        sut.addListeners()
        XCTAssertTrue(sut.currentUID == "NyeVduglGkQAgldAgG5durdJAer2")
    }
    
    func testIsUserConnectedMethod_WhenTheUserIsNotLog_ThenShouldReturnError() {
        let sut: AuthService = AuthService(auth: FakeAuth(false, error: .error))
        sut.addListeners()
        XCTAssertTrue(sut.currentUID == nil)
    }
}
