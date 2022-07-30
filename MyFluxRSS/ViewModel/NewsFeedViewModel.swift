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
    
    init() {
        self.parseArticleFromDatabaseFlux()
        // fait un GET sur articleRepo et FluxRepo
    }
    
    //MARK: - Functions
    
    //Add an article in bookmark DB
    func add(_ article: Article) {
        ArticleRepository.shared.add(article)
    }
   
    //Get bookmark articles from DB
    func parseArticleFromDatabaseFlux() {
        fluxRepository.get { flux in
            self.articles.removeAll()
            for strings in flux {
                guard let url = URL(string: strings.flux) else { return }
                let articleParsed = ArticleParser.parseArticles(url: url)
                self.articles.append(contentsOf: articleParsed)
            }
            self.articles.sort(by: { $0.date.compare($1.date) == .orderedDescending})
        }
    }
}
