//
//  RssParser.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 31/03/2022.
//

import Foundation

class RssParser: NSObject, XMLParserDelegate {
    
    var xmlParser: XMLParser!
    var currentElement = ""
    var foundCharacters = ""
    var currentData = [String:String]()
    var parsedData = [[String:String]]()
    var isHeader = true
    
    func startParsingWithContentsOfURL(rssUrl: URL, with completion: ([[String:String]])->()) {
        let parser = XMLParser(contentsOf: rssUrl)
        parser?.delegate = self
        if (parser?.parse()) != nil {
            parsedData.append(currentData)
            completion(parsedData)
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
            if currentElement == "title" || currentElement == "link" || currentElement == "description" || currentElement == "content" || currentElement == "pubDate" || currentElement == "author" || currentElement == "dc:creator" || currentElement == "content:encoded" || currentElement == "img" || currentElement == "link href" || currentElement == "summary" || currentElement == "id" || currentElement == "content" || currentElement == "logo" || currentElement == "contributor" || currentElement == "managingEditor"  {
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


