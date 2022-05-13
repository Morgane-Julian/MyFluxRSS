//
//  ArticleRepository.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 22/04/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine


class ArticleRepository : ObservableObject {
    
    //MARK: - Properties
    
    private let path: String = "articles"
    private let store = Firestore.firestore()
    
    var userId = ""
    private let authService = AuthService()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var articlesDatabase: [Article] = []
    
    //MARK: - Init
    
    init() {
        authService.$user
            .compactMap { user in
                user?.uid
            }
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)
        
        authService.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.get()
            }
            .store(in: &cancellables)
    }
    
    //MARK: - CRUD Functions
    
    func add(_ article: Article) {
        do {
            var newArticle = article
            newArticle.userId = userId
            _ = try store.collection(path).addDocument(from: newArticle)
            print("successfully add article")
        } catch {
            fatalError("Unable to add article: \(error.localizedDescription).")
        }
    }
    
    func get() {
        store.collection(path)
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting articles: \(error.localizedDescription)")
                return
            }
             self.articlesDatabase = querySnapshot?.documents.compactMap { document in
                try? document.data(as: Article.self)
            } ?? []
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
