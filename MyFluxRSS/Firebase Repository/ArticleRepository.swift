//
//  ArticleRepository.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 22/04/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class ArticleRepository : ObservableObject {
    
    static let shared: ArticleRepository = {
            let instance = ArticleRepository()
            return instance
        }()
    
    //MARK: - Properties
    
    private let path: String = "articles"
    private let store = Firestore.firestore()
    
    //MARK: - CRUD Functions
    
    func add(_ article: Article) {
        do {
            var newArticle = article
            if let userID = AuthService.shared.user?.providerID {
                newArticle.userId = userID
            }
            _ = try store.collection(path).addDocument(from: newArticle)
            print("successfully add article")
        } catch {
            fatalError("Unable to add article: \(error.localizedDescription).")
        }
    }
    
    func get(callback: @escaping ([Article]) -> Void) {
        store.collection(path)
            .whereField("userId", isEqualTo: AuthService.shared.user?.providerID as Any)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var articles = [Article]()
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        if let article = try? document.data(as: Article.self) {
                            articles.append(article)
                        }
                    }
                    callback(articles)
                }
            }
    }
    
    func remove(_ article: Article) {
        guard let articleId = article.id else { return }
        store.collection(path).document(articleId).delete { error in
            if let error = error {
                print("Unable to remove article: \(error.localizedDescription).")
            }
        }
    }
}
