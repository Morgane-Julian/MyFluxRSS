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
    
    //Get the DB bookmarks in our local table of bookmarks
    func getFavArticle() {
        ArticleRepository.shared.get(userID: InternalUser.shared.userID, callback: { articles in
            self.bookmarks = articles
        })
    }
    
    //Remove a bookmark article in DB and local tables of bookmarks
    func removeArticle(indexSet: IndexSet) {
        indexSet.forEach({ i in
            let article = bookmarks[i]
            if ArticleRepository.shared.remove(article) {
                self.bookmarks.remove(at: i)
            }
        })
    }
}
