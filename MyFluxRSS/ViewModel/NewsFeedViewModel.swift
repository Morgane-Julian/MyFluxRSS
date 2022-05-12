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
        articleRepository.add(article)
      }
   
    //TODO: - Ne récupère que le premier ! Il nous faut tous les flux de la bdd
    func parseArticleFromDatabase()  {
        fluxRepository.get()
        for strings in fluxRepository.fluxDatabase {
            guard let url = URL(string: strings.flux) else { return }
            self.articles += model.getArticles(url: url)
        }
    }
    
    func isFavorite() -> Bool {
        let favorite = articleRepository.articlesDatabase.filter { self.articles.contains($0) }
        if favorite != [] {
            return true
        }
        return false
    }
}

