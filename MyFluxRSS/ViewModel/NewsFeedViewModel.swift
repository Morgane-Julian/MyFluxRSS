//
//  NewsFeedViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import Foundation
import FirebaseFirestoreSwift

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
    func parseArticleFromDatabase() {
        fluxRepository.get()
        for strings in fluxRepository.fluxDatabase {
            guard let url = URL(string: strings.flux) else { return }
            self.articles += model.getArticles(url: url)
        }
        print(articles)
    }
    
    func isFavorite() -> Bool {
        let favorite = articleRepository.articlesDatabase.filter { self.articles.contains($0) }
        if favorite != [] {
            return true
        }
        return false
    }
}

struct Article: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var userId = ""
    var title: String = "Title"
    var image = "logo"
    var description: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    var date: String = ""
    var from: String = "Youtube"
    var link: String = ""
}
