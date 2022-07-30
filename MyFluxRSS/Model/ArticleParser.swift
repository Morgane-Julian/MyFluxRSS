//
//  Model.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 31/03/2022.
//

import Foundation
import FeedKit

class ArticleParser {
    
    //MARK: - Function for parse articles from RSS
    
    static func parseArticles(url: URL) -> [Article] {
        let parser = FeedParser(URL: url)
        let result = parser.parse()
        var finalArticle = [Article]()
        switch result {
        case .success(let feed):
            if let final = feed.rssFeed {
                for article in final.items! {
                    var articleProv = Article()
                    if article.description != nil && article.description!.count > 100 {
                        articleProv.description = article.description?.trunc(length: 100) ?? "Aucun aperçu disponible"
                    } else {
                        articleProv.description = article.description ?? "Aucun aperçu disponible"
                    }
                   articleProv.link = article.link!
                    articleProv.image = final.image?.url ?? "https://zupimages.net/up/22/15/hcop.png"
                    articleProv.title = article.title!
                    articleProv.author = article.author ?? ""
                    articleProv.id = UUID().uuidString
                    articleProv.date = article.pubDate ?? .now

                    if finalArticle.contains(where: { $0.link == articleProv.link }) {

                    } else {
                        finalArticle.append(articleProv)
                    }
                }
            }
        case .failure(let error):
            print(error)
        }
        return finalArticle
    }
}
