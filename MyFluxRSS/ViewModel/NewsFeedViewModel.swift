//
//  NewsFeedViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import Foundation


class NewsFeedViewModel: ObservableObject {
    
    let model = Model()
   
    @Published var articles = [Article]()
    @Published var articleRepository = ArticleRepository()
    @Published var fluxRepository = FluxRepository()
    
    //MARK: - Functions
    func add(_ article: Article) {
        articleRepository.get { articlesBDD in
            self.articleRepository.articlesDatabase = articlesBDD
            if self.articleRepository.articlesDatabase.contains(where: { $0.link == article.link}) {
                print("Article already in fav list BDD!")
            } else {
                self.articleRepository.add(article)
            }
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
}
