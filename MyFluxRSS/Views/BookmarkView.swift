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
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("My Favorite Articles").font(.title)
                }
            }
        } .navigationBarHidden(true)
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