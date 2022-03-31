//
//  Model.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 31/03/2022.
//

import Foundation

class Model {
    
    //MARK: Properties and Instances
    
    let rssParser = RssParser()
    
    //MARK: - Parsing RSS Flux
    
    func getArticles() {
        guard let url = URL(string: ParametersViewModel().urlString) else { return }
        rssParser.startParsingWithContentsOfURL(rssUrl: url) { (result) in
            let data = rssParser.parsedData
            for tables in data {
                print("\(tables)")
                // boucler sur les dictionnaire contenus dans data pour essayer de matcher des clés avec le contenu d'un article
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
