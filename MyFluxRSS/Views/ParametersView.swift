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
    @State private var isDarkModeOn = false
    
    
    //Theme functions
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    func setAppTheme() {
        isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
        changeDarkMode(state: isDarkModeOn)
    }
    
    func changeDarkMode(state: Bool) {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ? .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Général")) {
                    Toggle(isOn: $parametersViewModel.notifications) {
                        Text("Notifications")
                    }
                    Picker(selection: $parametersViewModel.previewOptions, label: Text("Aperçus")) {
                        ForEach(0 ..< parametersViewModel.previewOptions.count, id: \.self) {
                            Text(parametersViewModel.previewOptions[$0])
                        }
                    }
                }
                
                Section(header: Text("Thème")) {
                    Toggle("Dark Mode", isOn: $isDarkModeOn).onChange(of: self.isDarkModeOn) { state in
                        changeDarkMode(state: state)
                        UserDefaults.standard.set(self.isDarkModeOn, forKey: "themeToggle")
                        
                    }
                    .onAppear {
                        self.isDarkModeOn = UserDefaults.standard.bool(forKey: "themeToggle")
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
                    TextField("Saisir un nouveau flux", text: $parametersViewModel.urlString, onCommit: {
                            parametersViewModel.addNewFlux()
                    }).keyboardType(.URL)
                        .disableAutocorrection(true)
                    NavigationLink("Mes flux", destination: FluxListView(parametersViewModel: parametersViewModel))
                }
                .navigationTitle("Paramètres")
            }
            Button("Déconnexion") {
                parametersViewModel.disconnect()
                self.appState.moveToAuth = true
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
