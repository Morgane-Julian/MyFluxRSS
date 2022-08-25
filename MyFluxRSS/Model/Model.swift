//
//  Model.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 30/07/2022.
//

import Foundation

class Model {
    
    //MARK: - Properties
    let fluxRepository: FluxRepository
    var articles = [Article]()
    
    init(fluxRepository: FluxRepository = FluxRepository(repository: RepositoryFirebase(path: "flux"))) {
        self.fluxRepository = fluxRepository
    }
    
    //MARK: - Functions
    //Get bookmark articles from DB and parse articles from these bookmars into Articles
    func parseArticleFromDatabaseFlux(userId: String, callback: @escaping ([Article]) -> Void) {
        self.articles.removeAll()
        self.fluxRepository.get(userId: userId) { flux in
            for strings in flux {
                guard let url = URL(string: strings.flux) else { return }
                let articleParsed = ArticleParser.parseArticles(url: url)
                self.articles.append(contentsOf: articleParsed)
            }
            callback(self.articles)
        }
    }
}
