//
//  BookmarkView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 17/03/2022.
//

import SwiftUI

struct BookmarkView: View {
    
    let bookmarkViewModel: BookmarkViewModel
    var favArticle: Article
    
    var body: some View {
        NavigationView {
            List {
                ForEach(bookmarkViewModel.bookmarks) { item in
                    BookmarkView(bookmarkViewModel: bookmarkViewModel, favArticle: item)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("My Favorite Articles").font(.title)
                }
            }
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone 13 Pro Max"], id: \.self) {
            BookmarkView(bookmarkViewModel: BookmarkViewModel(), favArticle: Article())
                .previewDevice(.init(rawValue: $0))
                .previewDisplayName($0)
            //                .preferredColorScheme(.dark)
        }
    }
}
