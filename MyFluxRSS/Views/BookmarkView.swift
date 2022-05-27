//
//  BookmarkView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 17/03/2022.
//

import SwiftUI

struct BookmarkView: View {
    
    let bookmarkViewModel: BookmarkViewModel
    
    var body: some View {
       NavigationView {
            List {
                ForEach(bookmarkViewModel.bookmarks) { item in
                    ArticleView(article: item)
                }
            }.onAppear {
                bookmarkViewModel.getFavArticle()
            }
            //MARK: ajout du swipe vers la gauche pour supprimer l'article
            .swipeActions(edge: .trailing, content: {
                Button {
                    bookmarkViewModel.articleRepository.remove(self.body as! Article)
                } label: {
                    Label("Unfollow", systemImage: "star")
                }
            })
            //MARK: Fin du swipe
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("My Favorite Articles").font(.title)
                }
            }
        } .navigationBarHidden(false)
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (3rd generation)", "iPhone 13 Pro Max"], id: \.self) {
            BookmarkView(bookmarkViewModel: BookmarkViewModel())
                .previewDevice(.init(rawValue: $0))
                .previewDisplayName($0)
            //                .preferredColorScheme(.dark)
        }
    }
}
