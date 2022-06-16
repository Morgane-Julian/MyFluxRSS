//
//  BookmarkViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 17/03/2022.
//

import Foundation

class BookmarkViewModel: ObservableObject, Identifiable {
    
    @Published var bookmarks = [Article]() 
    @Published var articleRepository = ArticleRepository()
    
    func getFavArticle() {
        articleRepository.get { articles in
            self.bookmarks = articles
        }
    }
    
    func removeArticle(article: IndexSet) {
        let idToDelete = article.map { self.bookmarks[$0].id }
        _ = idToDelete.compactMap { [weak self] id in
            self?.articleRepository.remove(bookmarks.first(where: {$0.id == id})!)
            guard let intID = Int(id!) else { return }
            self?.bookmarks.remove(at: intID)
        }
    }
}
