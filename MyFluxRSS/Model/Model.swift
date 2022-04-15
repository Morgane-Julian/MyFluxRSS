//
//  Model.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 31/03/2022.
//

import Foundation
import UIKit

class Model {
    
    //MARK: Properties and Instances
    
    let rssParser = RssParser()
    
    //MARK: - Parsing RSS Flux
    
    func getArticles(url: URL) -> [Article] {
        var finalArticle: [Article] = []
        rssParser.startParsingWithContentsOfURL(rssUrl: url) { (result) in
            let data = rssParser.parsedData
            for _ in data {
                finalArticle = rssParser.parsedData.map {
                    Article(id: UUID.init(), title: $0["title"] ?? "", image: $0["image"] ?? "https://zupimages.net/up/22/15/hcop.png", description: $0["description"] ?? "", date: $0["pubDate"] ?? "", from: $0["author"] ?? "", link: $0["link"] ?? "")
                }
            }
        }
        return finalArticle
    }

    
    
    
    
    
    
    
    
    
    
    
}
