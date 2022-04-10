//
//  ContentView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import SwiftUI

struct AuthView: View {
    
    @StateObject var contentViewModel: AuthViewModel
    @State private var isShowingDetailView = false
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                        .padding()
                        .frame(height: 70)
                    Spacer()
                }
                .padding(50)
                VStack {
                    TextField("Adresse mail", text: $contentViewModel.userMail)
                        .padding()
                        .background(ColorManager.lightGray)
                        .cornerRadius(5.0)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    SecureField("Mot de passe", text: $contentViewModel.password)
                        .padding()
                        .background(ColorManager.lightGray)
                        .cornerRadius(5.0)
                        .padding()
                    HStack {
                        NavigationLink(destination: RegisterView(registerViewModel: RegisterViewModel())) {
                            Text("Pas encore inscrit ? C'est par ici")
                        }.isDetailLink(false)
                            .padding()
                    }
                    .onReceive(self.appState.$moveToDashboard) { moveToDashboard in
                        if moveToDashboard {
                            print("Move to dashboard: \(moveToDashboard)")
                            self.isShowingDetailView = false
                            self.appState.moveToDashboard = false
                        }
                    }
                    Spacer()
                }
                VStack {
                    NavigationLink(destination: NewsFeedView(newsFeedViewModel: NewsFeedViewModel()), isActive: $isShowingDetailView) { EmptyView() }
                    
                    Button("CONNEXION") {
                        Task {
                            try await contentViewModel.connect()
                            self.isShowingDetailView = true
                        }
                            
                    } .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [ColorManager.purple.opacity(0.5), ColorManager.turquoise.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(80.0)
                    Spacer()
                        .frame(height: 20)
                }
            }
        }.onAppear {
            isShowingDetailView = contentViewModel.isUserAlreadyLog()
        }
        .navigationBarHidden(true)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (3rd generation)", "iPhone 13 Pro Max"], id: \.self) {
            AuthView(contentViewModel: AuthViewModel.init())
                .previewDevice(.init(rawValue: $0))
                .previewDisplayName($0)
            //                .preferredColorScheme(.dark)
        }
    }
}
#endif
