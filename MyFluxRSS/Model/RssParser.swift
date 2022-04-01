//
//  RssParser.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 31/03/2022.
//

import Foundation

class RssParser: NSObject, XMLParserDelegate {
    
    var xmlParser: XMLParser!
    // la valeur de la balise XML courante
    var currentElement = ""
    // valeur de la balise dans currentElement
    var foundCharacters = ""
    //comme chaque élément item/entry contient plusieurs propriétés on les reconstruits dans un dictionnaire
    var currentData = [String:String]()
    // intégralité d'un flux rss contenu dans un tableau de dictionnaire avec les clés/valeurs pour chaque article du flux
    var parsedData = [[String:String]]()
    var isHeader = true
    
    func startParsingWithContentsOfURL(rssUrl: URL, with completion: (Bool)->()) {
        let parser = XMLParser(contentsOf: rssUrl)
        parser?.delegate = self
        if let flag = parser?.parse() {
            parsedData.append(currentData)
            completion(flag)
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        if currentElement == "item" || currentElement == "entry" {
            if isHeader == false {
                parsedData.append(currentData)
            }
            isHeader = false
        }
        if isHeader == false {
            if currentElement == "media:thumbnail" || currentElement == "media:content" {
                foundCharacters += attributeDict["url"]!
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if isHeader == false {
            if currentElement == "title" || currentElement == "link" || currentElement == "description" || currentElement == "content" || currentElement == "pubDate" || currentElement == "author" || currentElement == "dc:creator" || currentElement == "content:encoded" || currentElement == "img" {
                foundCharacters += string
                foundCharacters = foundCharacters.replacingOccurrences(of: "<a> <p> <div>", with: "")
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if !foundCharacters.isEmpty {
            foundCharacters = foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
            currentData[currentElement] = foundCharacters
            foundCharacters = ""
        }
    }
}
