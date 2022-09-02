//
//  NewsFeedViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import Foundation


class NewsFeedViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var articles = [Article]()
    let articleRepository : ArticleRepository
    let model = Model()
    
    //MARK: - Init
    
    init(articleRepository: ArticleRepository = ArticleRepository(repository: RepositoryFirebase(path: "articles"))) {
        self.articleRepository = articleRepository
    }
    
    //MARK: - Functions
    
    //Add an article in bookmark DB
    func add(_ article: Article, userID: String, callback: @escaping (Bool) -> Void) {
        self.articleRepository.add(article, userID: userID, callback: { success in
            callback(success)
        })
    }
    
    //Refresh article feed
    func refreshArticleFeed(userId: String, callback: @escaping (Bool) -> Void) {
        self.model.parseArticleFromDatabaseFlux(userId: userId, callback: { articles in
            self.articles = articles
            self.articles.sort(by: { $0.date.compare($1.date) == .orderedDescending})
            callback(true)
        })
        callback(false)
    }
}
