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
    let model = Model()
    
    //MARK: - Functions
    
    //Add an article in bookmark DB
    func add(_ article: Article) {
        ArticleRepository.shared.add(article, userID: InternalUser.shared.userID)
    }
    
    //Refresh article feed
    func refreshArticleFeed() {
        self.model.parseArticleFromDatabaseFlux(callback: { articles in
            self.articles = articles
            self.articles.sort(by: { $0.date.compare($1.date) == .orderedDescending})
        })
    }
}
