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
        List(bookmarkViewModel.bookmarks) { item in
            ArticleView(article: item)
                .swipeActions {
                    Button(role: .destructive, action: { bookmarkViewModel.removeArticle(article: item) } ) {
                        Label("Delete", systemImage: "trash")
                    }.tint(.purple)
                }
        }.onAppear {
            bookmarkViewModel.getFavArticle()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("My Favorite Articles").font(.title)
            }
        }
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
