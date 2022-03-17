//
//  FillView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import SwiftUI

struct FillView: View {
    
    @StateObject var fillViewModel: FillViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(fillViewModel.articles) { item in
                    ArticleView(article: item)
                }
            }
            .refreshable {
                //ajout la fonction qui permettra de récupérer la liste des articles
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                       //Ajoute un lien direct de flux rss ou refresh la liste ?
                    }) { Label("", systemImage: "arrow.triangle.2.circlepath")
                            .foregroundColor(Color.purple)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                       //Affiche les favoris
                    }) { Label("", systemImage: "star.fill")
                            .foregroundColor(Color.purple)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                       //Affiche la parametersView
                    }) { Label("", systemImage: "gear")
                            .foregroundColor(Color.purple)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("MyFluxRSS").font(.title)
                }
            }
        }
    }
    
#if DEBUG
    struct FillView_Previews: PreviewProvider {
        static var previews: some View {
            ForEach(["iPhone SE (2nd generation)", "iPhone 13 Pro Max"], id: \.self) {
                FillView(fillViewModel: FillViewModel())
                    .previewDevice(.init(rawValue: $0))
                    .previewDisplayName($0)
                //                .preferredColorScheme(.dark)
            }
        }
    }
#endif
}
