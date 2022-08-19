//
//  ArticleTest.swift
//  MyFluxRSSTests
//
//  Created by Morgane Julian on 19/08/2022.
//

import Foundation

class ArticleTest: Codable, Equatable {
    static func == (lhs: ArticleTest, rhs: ArticleTest) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    //MARK: - Properties
    var id = "XdkjhFrt7kclvk"
    var userId = "NyeVduglGkQAgldAgG5durdJAer2"
    var title = "WWDC22: Wrap up and recommended talks"
    var image = "https://zupimages.net/up/22/15/hcop.png"
    var description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    var date = Date.now
    var author = "Morgane Julian"
    var link: String = "https://www.morgane-julian.com"
}

class FakeResponseData {
    static var articles = [ArticleTest]()
}
