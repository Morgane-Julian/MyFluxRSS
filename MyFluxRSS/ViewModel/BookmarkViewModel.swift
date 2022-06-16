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
    
    func getFavArticle() {
        articleRepository.get { articles in
            if self.bookmarks != articles {
                self.bookmarks = articles
            }
        }
    }

    func removeArticle(article: Article) {
        articleRepository.remove(article)
        if let index = self.bookmarks.firstIndex(of: article) {
            self.bookmarks.remove(at: index)
        }
    }
}
