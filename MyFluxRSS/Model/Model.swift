//
//  Model.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 31/03/2022.
//

import Foundation
import FeedKit

class Model {
    
    //MARK: - Properties
    var finalArticle: [Article] = []
    var articleProv = Article()
    var rssFeed = RSSFeed()
    
    //MARK: - Functions
    func parseArticles(url: URL, with completion: ([Article])->()) {
        let parser = FeedParser(URL: url)
        let result = parser.parse()
        switch result {
        case .success(let feed):
            if let final = feed.rssFeed {
                for article in final.items! {
                    if article.description != nil && article.description!.count > 100 {
                        self.articleProv.description = article.description?.trunc(length: 100) ?? "Aucun aperçu disponible"
                    } else {
                        self.articleProv.description = article.description ?? "Aucun aperçu disponible"
                    }
                    self.articleProv.link = article.link!
                    self.articleProv.image = final.image?.url ?? "https://zupimages.net/up/22/15/hcop.png"
                    self.articleProv.title = article.title!
                    self.articleProv.author = article.author ?? ""
                    self.articleProv.id = UUID().uuidString
                    self.articleProv.date = article.pubDate ?? .now
                    
                    if self.finalArticle.contains(where: { $0.link == self.articleProv.link }) {
                        print("Oups, article already in feed")
                    } else {
                        self.finalArticle.append(self.articleProv)
                    }
                }
            }
        case .failure(let error):
            print(error)
        }
        completion(finalArticle)
    }
    
    
    
    
}
