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
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    func setAppTheme() {
        isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
        parametersViewModel.changeDarkMode(state: isDarkModeOn)
    }
   
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Thème")) {
                    Toggle("Dark Mode", isOn: $isDarkModeOn).onChange(of: self.isDarkModeOn) { state in
                        parametersViewModel.changeDarkMode(state: state)
                        UserDefaults.standard.set(self.isDarkModeOn, forKey: "themeToggle")
                        
                    }
                    .onAppear {
                        self.isDarkModeOn = UserDefaults.standard.bool(forKey: "themeToggle")
                    }
                }
                Section(header: Text("Flux")) {
                    TextField("Saisir un nouveau flux", text: $parametersViewModel.urlString, onCommit: {
                            parametersViewModel.addNewFlux()
                        parametersViewModel.urlString = ""
                    }).keyboardType(.URL)
                        .disableAutocorrection(true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .submitLabel(.done)
                    NavigationLink("Mes flux", destination: FluxListView(parametersViewModel: parametersViewModel))
                }
                .navigationTitle("Paramètres")
            }
            Button("Déconnexion") {
                parametersViewModel.disconnect()
                self.appState.moveToAuth = true
            }.padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color("ButtonLightGradient").opacity(0.5), Color("ButtonDarkGradient").opacity(0.5)]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(80.0)
                .foregroundColor(.black)
                .font(.title2)
                
            Spacer()
                .frame(height: 20)
        }.background(Color.gray.opacity(0.1))
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
