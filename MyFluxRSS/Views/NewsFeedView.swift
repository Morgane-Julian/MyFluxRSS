//
//  FillView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import SwiftUI

struct NewsFeedView: View {
    
    //MARK: - Properties
    
    @StateObject var newsFeedViewModel = NewsFeedViewModel()
    @State private var isShowingAlert = false
    @State private var isShowingAlertAddBookmark = false
    
    var body: some View {
        NavigationView {
            
            //MARK: - FEED ITEMS
            
            VStack {
                ScrollViewReader { scrollView in
                    List(newsFeedViewModel.articles) { item in
                        ArticleView(article: item)
                            .swipeActions {
                                Button {
                                    newsFeedViewModel.add(item, userID: InternalUser.shared.userID, callback: { success in
                                        if !success {
                                            self.isShowingAlertAddBookmark = success
                                        }
                                    })
                                } label: {
                                    Label("Favorite", systemImage: "star")
                                }.alert("Impossible d'ajouter l'article en favoris, veuillez réessayer", isPresented: $isShowingAlert) {
                                    Button("OK", role: .cancel) { }
                                }
                                .tint(.purple)
                            } .id(newsFeedViewModel.articles.firstIndex(of: item))
                    }
                    .refreshable {
                        newsFeedViewModel.refreshArticleFeed(userId: InternalUser.shared.userID, callback: { success in
                            if !success {
                                self.isShowingAlert = true
                            }
                        })
                        scrollView.scrollTo(0)
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    
                    //MARK: - TOOLBAR ITEMS
                    
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                newsFeedViewModel.refreshArticleFeed(userId: InternalUser.shared.userID, callback: { success in
                                    if !success {
                                        self.isShowingAlert = true
                                    }
                                })
                                scrollView.scrollTo(0)
                            }) { Label("", systemImage: "arrow.triangle.2.circlepath")
                                    .foregroundColor(Color.purple)
                            }.alert("Une erreur s'est produite lors du chargement des articles, vérifiez votre connexion internet", isPresented: $isShowingAlert) {
                                Button("OK", role: .cancel) { }
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
            }.onAppear {
                newsFeedViewModel.refreshArticleFeed(userId: InternalUser.shared.userID, callback: { _ in })
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
