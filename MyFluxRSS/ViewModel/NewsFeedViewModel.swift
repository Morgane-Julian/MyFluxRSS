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
    var fluxRepository = FluxRepository()
    var articleRepository = ArticleRepository()
    
    init() {
        
        //GET the user bookmarks flux and parse it into Articles
        self.parseArticleFromDatabaseFlux()
        
        //Get the user bookmarks articles
        self.articleRepository.get(userID: FIRUser.shared.userID, callback: { articles in
            FIRUser.shared.articleDatabase = articles
        })
    }
    
    //MARK: - Functions
    
    //Add an article in bookmark DB
    func add(_ article: Article) {
        if self.articleRepository.add(article, userID: FIRUser.shared.userID) {
            refreshBookmarkArticles()
        }
    }
    
    //Refresh the local bookmarks
    func refreshBookmarkArticles() {
        self.articleRepository.get(userID: FIRUser.shared.userID, callback: { articles in
            FIRUser.shared.articleDatabase = articles
        })
    }
   
    //Get bookmark articles from DB
    func parseArticleFromDatabaseFlux() {
        self.fluxRepository.get { flux in
            self.articles.removeAll()
            FIRUser.shared.fluxDatabase = flux
            for strings in flux {
                guard let url = URL(string: strings.flux) else { return }
                let articleParsed = ArticleParser.parseArticles(url: url)
                self.articles.append(contentsOf: articleParsed)
            }
            self.articles.sort(by: { $0.date.compare($1.date) == .orderedDescending})
        }
    }
}
