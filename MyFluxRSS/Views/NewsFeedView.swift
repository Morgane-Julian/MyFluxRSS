//
//  FillView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import SwiftUI

struct NewsFeedView: View {
    
    @StateObject var newsFeedViewModel: NewsFeedViewModel
    @State var isShowingAuthView = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: AuthView(contentViewModel: AuthViewModel()), isActive: $isShowingAuthView) { EmptyView() }
                
                List {
                    ForEach(newsFeedViewModel.articles) { item in
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
                            //refresh la liste
                        }) { Label("", systemImage: "arrow.triangle.2.circlepath")
                                .foregroundColor(Color.purple)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: BookmarkView(bookmarkViewModel: BookmarkViewModel())) {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.purple)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: ParametersView(parametersViewModel: ParametersViewModel())) {
                            Image(systemName: "gear")
                                .foregroundColor(Color.purple)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("MyFluxRSS").font(.title)
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
    
#if DEBUG
    struct FillView_Previews: PreviewProvider {
        static var previews: some View {
            ForEach(["iPhone SE (3rd generation)", "iPhone 13 Pro Max"], id: \.self) {
                NewsFeedView(newsFeedViewModel: NewsFeedViewModel())
                    .previewDevice(.init(rawValue: $0))
                    .previewDisplayName($0)
                //                .preferredColorScheme(.dark)
            }
        }
    }
#endif
}
