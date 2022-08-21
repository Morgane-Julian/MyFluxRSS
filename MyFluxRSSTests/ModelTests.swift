//
//  ModelTests.swift
//  MyFluxRSSTests
//
//  Created by Morgane Julian on 19/08/2022.
//
import XCTest
@testable import MyFluxRSS

final class ModelTests: XCTestCase {

    func testParseArticleMethod_WhenPassAFluxRss_ThenShouldReturnArticles() {
        let url = URL(string: "https://www.hackingwithswift.com/articles/rss")!
        let articles = ArticleParser.parseArticles(url: url)
        XCTAssertTrue(articles.first?.title == "WWDC22: Wrap up and recommended talks")
    }
    
    func testParseArticleMethod_WhenPassABAdFlux_ThenShouldReturnAnError() {
        let url = URL(string: "https://www.wift.com/")!
        let articles = ArticleParser.parseArticles(url: url)
        XCTAssertTrue(articles.isEmpty)
    }
}
