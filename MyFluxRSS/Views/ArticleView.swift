//
//  ArticleView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import SwiftUI

struct ArticleView: View {
    
    var article = Article()
    @Environment(\.openURL) var openURL
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "\(article.image)")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 80)
                .clipShape(Circle())
//            AsyncImage(url: URL(string: "\(article.image)"))
//                .scaledToFit()
//                .frame(width: 50, height: 50, alignment: .center)
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("\(article.title)")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                       //TODO: Ajoute l'article aux favoris
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
        .onTapGesture {
            openURL(URL(string: article.link)!)
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (3rd generation)", "iPhone 13 Pro Max"], id: \.self) {
            ArticleView(article: Article())
                .previewDevice(.init(rawValue: $0))
                .previewDisplayName($0)
            //                .preferredColorScheme(.dark)
        }
    }
}
