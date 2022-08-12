////
////  AuthServiceTests.swift
////  MyFluxRSSTests
////
////  Created by Morgane Julian on 12/08/2022.
////
//
//import XCTest
//@testable import MyFluxRSS
//
//final class AuthServiceTests: XCTestCase {
//
//    // MARK: - Helpers
//
//    private class AuthTest: AuthType {
//        
//        private let isSuccess: Bool
//
//        var currentUID: String? { return isSuccess ? "NyeVduglGkQAgldAgG5durdJAer2" : nil }
//
//        init(_ isSuccess: Bool) {
//            self.isSuccess = isSuccess
//        }
//        
//        func createUser(userMail: String, userPassword: String, callback: @escaping (Bool) -> Void) {
//            <#code#>
//        }
//        
//        func signIn(email: String, password: String, callback: @escaping (Bool, Error?) -> Void) {
//            <#code#>
//        }
//        
//        func isUserConnected() {
//            <#code#>
//        }
//        
//        func reauthenticate(credential: AuthCredential, callback: @escaping (Bool) -> Void) {
//            <#code#>
//        }
//        
//        func changePassword(password: String, callback: @escaping (Bool, Error?) -> Void) {
//            <#code#>
//        }
//        
//        func deleteAccount(callback: @escaping (Bool, Error?) -> Void) {
//            <#code#>
//        }
//    }
//
//    // MARK: - Tests
//
//    func testCurrentUID_WhenTheUserIsConnected_ThenShouldReturnAValue() {
//        let sut: AuthService = AuthService(auth: AuthTest(true))
//        let expectedUID: String = "NyeVduglGkQAgldAgG5durdJAer2"
//        XCTAssertTrue(sut.currentUID! == expectedUID)
//    }
//
//    func testCurrentUID_WhenTheUserIsDisconnected_ThenShouldReturnANilValue() {
//        let sut: AuthService = AuthService(auth: AuthTest(false))
//        let expectedUID: String? = nil
//        XCTAssertTrue(sut.currentUID == expectedUID)
//    }
//
//    func testSignInMethod_WhenTheUserEnterCorrectData_ThenShouldConnectTheUser() {
//        let sut: AuthService = AuthService(auth: AuthTest(true))
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        sut.signIn(email: "CorrectMail", password: "CorrectPassword") { isSuccess in
//            XCTAssertTrue(isSuccess == true)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testSignInMethod_WhenTheUserEnterIncorrectData_ThenShouldNotConnectTheUser() {
//        let sut: AuthService = AuthService(auth: AuthTest(false))
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        sut.signIn(email: "IncorrectMail", password: "IncorrectPassword") { isSuccess in
//            XCTAssertTrue(isSuccess == false)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testSignUpMethod_WhenTheUserEnterCorrectData_ThenShouldCreateTheUser() {
//        let sut: AuthService = AuthService(auth: AuthTest(true))
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        sut.signUp(userName: "Username", email: "Email", password: "Password") { isSuccess in
//            XCTAssertTrue(isSuccess == true)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testSignUpMethod_WhenTheUserEnterIncorrectData_ThenShouldNotCreateTheUser() {
//        let sut: AuthService = AuthService(auth: AuthTest(false))
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        sut.signUp(userName: "Username", email: "Email", password: "") { isSuccess in
//            XCTAssertTrue(isSuccess == false)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testSignOutMethod_WhenTheUserWantsToBeDisconnected_ThenTheUserShouldBeDisconnected() {
//        let sut: AuthService = AuthService(auth: AuthTest(true))
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        sut.signOut { isSuccess in
//            XCTAssertTrue(isSuccess == true)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testSignOutMethod_WhenTheUserWantsToBeDisconnected_ThenTheUserShouldNotBeDisconnected() {
//        let sut: AuthService = AuthService(auth: AuthTest(false))
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        sut.signOut { isSuccess in
//            XCTAssertTrue(isSuccess == false)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testIsUserConnectedMethod_WhenTheUserIsConnected_ThenTheListenerShouldNotifyAConnectedUser() {
//        let sut: AuthService = AuthService(auth: AuthTest(true))
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        sut.isUserConnected { isSuccess in
//            XCTAssertTrue(isSuccess == true)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testIsUserConnectedMethod_WhenTheUserIsDisonnected_ThenTheListenerShouldNotifyADisconnectedUser() {
//        let sut: AuthService = AuthService(auth: AuthTest(false))
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        sut.isUserConnected { isSuccess in
//            XCTAssertTrue(isSuccess == false)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//}
//
