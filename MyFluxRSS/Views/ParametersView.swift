//
//  Parameters.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 17/03/2022.
//

import SwiftUI

struct ParametersView: View {
    
    @StateObject var parametersViewModel: ParametersViewModel
    @State private var isShowingDetailView = false
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Général")) {
                    Toggle(isOn: $parametersViewModel.notifications) {
                        Text("Notifications")
                    }
                    Picker(selection: $parametersViewModel.previewOptions, label: Text("Aperçus")) {
                        ForEach(0 ..< parametersViewModel.previewOptions.count) {
                            Text(parametersViewModel.previewOptions[$0])
                        }
                    }
                    Picker(selection: $parametersViewModel.theme, label: Text("Thème")) {
                        ForEach(0 ..< parametersViewModel.theme.count) {
                            Text(parametersViewModel.theme[$0])
                        }
                    }
                }
                Section(header: Text("Réseaux")) {
                    Toggle(isOn: $parametersViewModel.reddit) {
                        Text("Reddit")
                    }
                    Toggle(isOn: $parametersViewModel.facebook) {
                        Text("Facebook")
                    }
                    Toggle(isOn: $parametersViewModel.youtube) {
                        Text("Youtube")
                    }
                    Toggle(isOn: $parametersViewModel.twitter) {
                        Text("Twitter")
                    }
                }
                Section(header: Text("Flux")) {
                    TextField("Saisir un nouveau flux", text: $parametersViewModel.urlString, onEditingChanged: { changed in
                        //TODO: le flux apparait vide et se rempli seulement si on en rentre un nouveau
                        if changed {
                            parametersViewModel.addNewFlux()
                        }
                    })
                    NavigationLink("Mes flux", destination: FluxListView(parametersViewModel: parametersViewModel))
                }
                .navigationTitle("Paramètres")
            }
            Button("Déconnexion") {
                parametersViewModel.disconnect()
                self.appState.moveToDashboard = true
            }.padding()
            
        }  .background(Color.gray.opacity(0.1))
    }
}




#if DEBUG
struct ParametersView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (3rd generation)", "iPhone 13 Pro Max"], id: \.self) {
            ParametersView(parametersViewModel: ParametersViewModel())
                .previewDevice(.init(rawValue: $0))
                .previewDisplayName($0)
            //                .preferredColorScheme(.dark)
        }
    }
}
#endif
