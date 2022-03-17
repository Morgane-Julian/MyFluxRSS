//
//  ArticleView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import SwiftUI

struct ArticleView: View {
    
    var article: Article
    
    var body: some View {
        HStack {
            Image(article.image)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80, alignment: .center)
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("\(article.title)")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                       //Ajoute l'article aux favoris
                    }) { Label("", systemImage: "star")
                            .foregroundColor(Color.purple)
                    }
                }
                Text("\(article.description)")
                    .font(.caption)
                    .foregroundColor(Color.secondary)
            }
        }
        .padding()
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article())
    }
}
