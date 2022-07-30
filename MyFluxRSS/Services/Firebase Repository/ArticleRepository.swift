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
    
    //MARK: - Properties
    
    private let path: String = "articles"
    private let store = Firestore.firestore()
    
    //MARK: - CRUD Functions
    
    func add(_ article: Article, userID: String) -> Bool {
        do {
            var newArticle = article
                newArticle.userId = userID
            _ = try store.collection(path).addDocument(from: newArticle)
            print("successfully add article")
            return true
        } catch {
            fatalError("Unable to add article: \(error.localizedDescription).")
        }
    }
    
    func get(userID: String, callback: @escaping ([Article]) -> Void) {
        store.collection(path)
            .whereField("userId", isEqualTo: userID)
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
    
    func remove(_ article: Article) -> Bool {
        guard let articleId = article.id else { return false }
        store.collection(path).document(articleId).delete { error in
            if let error = error {
                print("Unable to remove article: \(error.localizedDescription).")
            }
        }
        return true
    }
}
