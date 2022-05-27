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
   
    func parseArticleFromDatabaseFlux() {
        fluxRepository.get()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            for strings in self.fluxRepository.fluxDatabase {
                guard let url = URL(string: strings.flux) else { return }
                self.model.getArticles(url: url) { result in
                    self.articles += result
                }
            }
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

