//
//  AuthServiceTests.swift
//  MyFluxRSSTests
//
//  Created by Morgane Julian on 12/08/2022.
//

import XCTest
@testable import MyFluxRSS

final class AuthServiceTests: XCTestCase {

    // MARK: - Helpers
    enum ErrorType: Error {
        case error
        case noError
    }

    private class AuthTest: AuthType {
        
        private let isSuccess: Bool
        private let error: Error

        var currentUID: String? { return isSuccess ? "NyeVduglGkQAgldAgG5durdJAer2" : nil }

        init(_ isSuccess: Bool, error: ErrorType) {
            self.isSuccess = isSuccess
            self.error = error
        }

        func createUser(userMail: String, userPassword: String, callback: @escaping (Bool) -> Void) {
            callback(isSuccess)
        }

        func signIn(email: String, password: String, callback: @escaping (Bool, Error?) -> Void) {
            callback(isSuccess, error)
        }

        func isUserConnected() {
            
        }

        func reauthenticate(email: String, password: String, callback: @escaping (Bool) -> Void) {
            callback(isSuccess)
        }

        func changePassword(password: String, callback: @escaping (Bool, Error?) -> Void) {
            callback(isSuccess, error)
        }

        func deleteAccount(callback: @escaping (Bool, Error?) -> Void) {
            callback(isSuccess, error)
        }
        
        func signOut(callback: @escaping (Bool) -> Void) {
            callback(isSuccess)
        }
    }

    // MARK: - Tests

    func testCurrentUID_WhenTheUserIsConnected_ThenShouldReturnAValue() {
        let sut: AuthService = AuthService(auth: AuthTest(true, error: .noError))
        let expectedUID: String = "NyeVduglGkQAgldAgG5durdJAer2"
        XCTAssertTrue(sut.currentUID! == expectedUID)
    }

    func testCurrentUID_WhenTheUserIsDisconnected_ThenShouldReturnANilValue() {
        let sut: AuthService = AuthService(auth: AuthTest(false, error: .error))
        let expectedUID: String? = nil
        XCTAssertTrue(sut.currentUID == expectedUID)
    }

    func testSignInMethod_WhenTheUserEnterCorrectData_ThenShouldConnectTheUser() {
        let sut: AuthService = AuthService(auth: AuthTest(true, error: .noError))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.connect(userMail: "CorrectMail", password: "CorrectPassword", callback: { isSuccess in
            XCTAssertTrue(isSuccess == true)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testSignInMethod_WhenTheUserEnterIncorrectData_ThenShouldNotConnectTheUser() {
        let sut: AuthService = AuthService(auth: AuthTest(false, error: .error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.connect(userMail: "IncorrectMail", password: "IncorrectPassword", callback: { isSuccess in
            XCTAssertTrue(isSuccess == false)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testSignUpMethod_WhenTheUserEnterCorrectData_ThenShouldCreateTheUser() {
        let sut: AuthService = AuthService(auth: AuthTest(true, error: .noError))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.inscription(userMail: "Email", userPassword: "Password", callback: { isSuccess in
            XCTAssertTrue(isSuccess == true)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testSignUpMethod_WhenTheUserEnterIncorrectData_ThenShouldNotCreateTheUser() {
        let sut: AuthService = AuthService(auth: AuthTest(false, error: .error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.inscription(userMail: "Email", userPassword: "Password", callback: { isSuccess in
            XCTAssertTrue(isSuccess == false)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testSignOutMethod_WhenTheUserWantsToBeDisconnected_ThenTheUserShouldBeDisconnected() {
        let sut: AuthService = AuthService(auth: AuthTest(true, error: .noError))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.disconnect(callback: { isSuccess in
            XCTAssertTrue(isSuccess == true)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testSignOutMethod_WhenTheUserWantsToBeDisconnected_ThenTheUserShouldNotBeDisconnected() {
        let sut: AuthService = AuthService(auth: AuthTest(false, error: .error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.disconnect(callback: { isSuccess in
            XCTAssertTrue(isSuccess == false)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testReauthenticateMethod_WhenTheUserNeedToBeReauthenticate_ThenTheUserShouldBeReauthenticate() {
        let sut: AuthService = AuthService(auth: AuthTest(true, error: .noError))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.reauthenticate(email: "Email", password: "Password", callback: { isSuccess in
            XCTAssertTrue(isSuccess == true)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testReauthenticateMethod_WhenTheUserNeedToBeReauthenticate_ThenTheUserShouldNotBeReauthenticate() {
        let sut: AuthService = AuthService(auth: AuthTest(false, error: .error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        sut.reauthenticate(email: "Email", password: "WrongPassword", callback: { isSuccess in
            XCTAssertTrue(isSuccess == false)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testChangePasswordMethod_WhenTheUserWantToChangePassword_ThenTheUserShouldSaveNewPassword() {
        let sut: AuthService = AuthService(auth: AuthTest(true, error: .noError))
        sut.changePassword(password: "NewPassword")
        XCTAssertTrue(sut.changePasswordMessage == "Le mot de passe a été mis à jour")
        }
    
    func testChangePasswordMethod_WhenTheUserWantToChangePassword_ThenTheUserShouldNotSaveNewPassword() {
        let sut: AuthService = AuthService(auth: AuthTest(false, error: .error))
        sut.changePassword(password: "NewPassword")
        XCTAssertEqual(sut.changePasswordMessage, "Une erreur s'est produite, veuillez réassayer")
        }
    
    func testDeleteAccountMethod_WhenTheUserWantDeleteAccount_ThenAccountIsDeleted() {
        let sut: AuthService = AuthService(auth: AuthTest(true, error: .noError))
        sut.deleteAcount()
        XCTAssertEqual(sut.deleteAccountError, "")
    }
    
    func testDeleteAccountMethod_WhenTheUserWantDeleteAccount_ThenAccountIsNotDeleted() {
        let sut: AuthService = AuthService(auth: AuthTest(false, error: .error))
        sut.deleteAcount()
        XCTAssertEqual(sut.deleteAccountError , "Une erreur s'est produite, veuillez réassayer")
    }
}
