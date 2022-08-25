//
//  FluxRepositoryTest.swift
//  MyFluxRSSTests
//
//  Created by Morgane Julian on 25/08/2022.
//

import Foundation
@testable import MyFluxRSS

class FakeFluxRepository: Repository {
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
