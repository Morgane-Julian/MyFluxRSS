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
            if self.bookmarks == articles {
                print("This article is already in bookmark list")
            } else {
            self.bookmarks = articles
            }
        }
        bookmarks.append(Article(id: "12", userId: "", title: "test", image: "test", description: "test", date: .now, author: "test", link: "test"))
    }

    func removeArticle(article: Article) {
        articleRepository.remove(article)
    }
}
