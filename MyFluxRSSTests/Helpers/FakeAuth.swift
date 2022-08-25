//
//  AuthTest.swift
//  MyFluxRSSTests
//
//  Created by Morgane Julian on 25/08/2022.
//

import Foundation
@testable import MyFluxRSS

class FakeAuth: AuthType {
    
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
        if isSuccess {
            print("User Connected")
        } else {
            print("No user found")
        }
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
    
    // MARK: - Helpers
    enum ErrorType: Error {
        case error
        case noError
    }

}
