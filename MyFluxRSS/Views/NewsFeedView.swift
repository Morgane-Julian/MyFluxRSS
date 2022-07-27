//
//  FillView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import SwiftUI

struct NewsFeedView: View {
    
    @ObservedObject var newsFeedViewModel: NewsFeedViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollViewReader { scrollView in
                    List(newsFeedViewModel.articles) { item in
                        ArticleView(article: item)
                            .swipeActions {
                                Button {
                                    newsFeedViewModel.add(item)
                                } label: {
                                    Label("Favorite", systemImage: "star")
                                }
                                .tint(.purple)
                            } .id(newsFeedViewModel.articles.firstIndex(of: item))
                    }
                    .onAppear {
                        newsFeedViewModel.parseArticleFromDatabaseFlux()
                    }.refreshable {
                        newsFeedViewModel.parseArticleFromDatabaseFlux()
                        scrollView.scrollTo(0)
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                newsFeedViewModel.parseArticleFromDatabaseFlux()
                                //Revenir au déut de la liste ..
                                scrollView.scrollTo(0)
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
            
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
