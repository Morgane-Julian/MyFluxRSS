//
//  ArticleRepositoryTest.swift
//  MyFluxRSSTests
//
//  Created by Morgane Julian on 25/08/2022.
//

import Foundation
@testable import MyFluxRSS


class FakeArticleRepository: Repository {
    
    var path: String
    private let isSuccess: Bool
    typealias T = Article
    var database: [Article] = []
    
    init(path: String, isSuccess: Bool) {
        self.path = path
        self.isSuccess = isSuccess
    }
    
    func addDocument<T>(document: T, userID: String, callback: @escaping (Bool) -> Void) where T : Decodable, T : Encodable {
        if userID == "NyeVduglGkQAgldAgG5durdJAer2" {
            callback(true)
        } else {
            callback(false)
        }
    }
    
    func getDocument<T>(userID: String, callback: @escaping ([T]) -> Void) where T : Decodable, T : Encodable {
        if userID == "NyeVduglGkQAgldAgG5durdJAer2" {
            callback([Article()] as! [T])
        } else {
            callback([])
        }
    }
    
    func deleteDocument(documentID: String, callback: @escaping (Bool) -> Void) {
        callback(isSuccess)
    }
}
