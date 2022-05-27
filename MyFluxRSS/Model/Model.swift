//
//  Model.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 31/03/2022.
//

import Foundation

class Model {
    
    //MARK: - Properties and Instances
    
    let rssParser = RssParser()
    
    //MARK: - Parsing Functions
    
    func getArticles(url: URL, with completion: ([Article])->())  {
        var finalArticle: [Article] = []
        rssParser.startParsingWithContentsOfURL(rssUrl: url) { (result) in
            for _ in result {
                finalArticle = result.map {
                    Article(id: $0["id"] ?? UUID().uuidString, title: $0["title"] ?? "", image: $0["image"] ?? "https://zupimages.net/up/22/15/hcop.png", description: $0["description"] ?? "Aucun aperçu disponible pour cet article", date: $0["pubDate"] ?? "", from: $0["author"] ?? "", link: ($0["link"] ?? ""))
                }
            }
        }
        completion(finalArticle)
    }

    
    
    
    
    
    
    
    
    
    
    
}
