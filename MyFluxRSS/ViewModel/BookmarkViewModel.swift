//
//  BookmarkViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 17/03/2022.
//

import Foundation

class BookmarkViewModel: ObservableObject, Identifiable {
    
    //MARK: - Properties
    
    @Published var bookmarks = [Article]()
    
    //MARK: - DB Functions
    
    //Get the bookmarks from DB in our local table of bookmarks
    func getFavArticle() {
        ArticleRepository.shared.get { articles in
            self.bookmarks = articles
        }
    }
    
    //Remove a bookmark article in DB and local table of bookmarks
    func removeArticle(article: IndexSet) {
        let idToDelete = article.map { self.bookmarks[$0].id }
        _ = idToDelete.compactMap { [weak self] id in
            ArticleRepository.shared.remove(bookmarks.first(where: {$0.id == id})!)
            guard let intID = Int(id!) else { return }
            self?.bookmarks.remove(at: intID)
        }
    }
}
