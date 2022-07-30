//
//  ArticleView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import SwiftUI

struct ArticleView: View {
    
    //MARK: - Properties
    
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
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    VStack {
                        Text("\(article.title)")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                }
                Text("\(article.description)")
                    .font(.subheadline)
                    .foregroundColor(Color.secondary)
                    .onTapGesture {
                        openURL(URL(string: article.link)!)
                    }
                    .multilineTextAlignment(.leading)
            }
        }
        .padding()
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
