//
//  NewsFeedViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import Foundation


class NewsFeedViewModel: ObservableObject {
    
    let model = Model()
   
    @Published var articles : [Article] = []
    @Published var articleRepository = ArticleRepository()
    @Published var fluxRepository = FluxRepository()
    
    //MARK: - Functions
    func add(_ article: Article) {
        if isFavorite(final: article) {
            print("article déjà dans les favoris")
        } else {
            articleRepository.add(article)
        }
    }
   
    func parseArticleFromDatabaseFlux() {
        fluxRepository.get { flux in
            for strings in flux {
                guard let url = URL(string: strings.flux) else { return }
                self.model.parseArticles(url: url) { result in
                    if self.articles == result {
                        print("Article already parsed")
                    } else {
                    self.articles = result
                    self.articles.sort(by: { $0.date.compare($1.date) == .orderedDescending})
                    }
                }
            }
        }
    }
    
    func isFavorite(final: Article) -> Bool {
        var isFavorite = Bool()
        articleRepository.get { article in
            if article.contains(final) {
                isFavorite = true
            } else {
                isFavorite = false
            }
        }
        return isFavorite
    }
}

