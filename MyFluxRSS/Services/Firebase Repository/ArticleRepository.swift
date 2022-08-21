//
//  ArticleRepository.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 22/04/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


final class ArticleRepository : ObservableObject {
    
    //Create a singleton instance of article repository
    static let shared: ArticleRepository = {
        let instance = ArticleRepository()
        return instance
    }()
    
    //MARK: - Properties
    private let repository: Repository
    
    //MARK: - Init
    init(repository: Repository = RepositoryFirebase(path: "articles")) {
        self.repository = repository
    }
    
    //MARK: - CRUD Functions
    
    // add a bookmark article in DB
    func add(_ article: Article, userID: String) {
            var newArticle = article
            newArticle.userId = userID
        self.repository.addDocument(document: newArticle, userID: userID,callback: { success in
            if success {
                print("Article add in db")
            } else {
                print("No article inserted in db")
            }
        })
    }
    
    // get the bookmark articles from DB
    
    func get(userID: String, callback: @escaping ([Article]) -> Void) {
        self.repository.getDocument(userID: userID, callback: callback)
    }
    
    //Delete a bookmark article in DB
    func remove(_ article: Article) -> Bool {
        var successDeleteArticle = false
        guard let articleId = article.id else { return false }
        self.repository.deleteDocument(documentID: articleId, callback: { success in
            successDeleteArticle = true
        })
        return successDeleteArticle
    }
}
