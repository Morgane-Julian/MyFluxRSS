//
//  BookmarkViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 17/03/2022.
//

import Foundation

class BookmarkViewModel: ObservableObject, Identifiable {
    
    @Published var bookmarks : [Article] = []
    @Published var articleRepository = ArticleRepository()
    var id = ""
    
    func getFavArticle() {
        articleRepository.get()
        self.bookmarks = articleRepository.articlesDatabase
    }

    func removeArticle(article: Article) {
        articleRepository.remove(article)
    }
}
