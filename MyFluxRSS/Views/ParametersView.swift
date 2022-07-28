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
    @State private var showingPopover = false
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
                Section(header: Text("Gestion du compte")) {
                    Button("Réinitialiser le mot de passe") {
                        // l'utilisateur doit se ré authentifier
                        showingPopover = true
                    }.foregroundColor(.black)
                    NavigationLink("Supprimer mon compte", destination: DeleteAcountView(parametersViewModel: ParametersViewModel()))
                }.foregroundColor(.black)
                
                .navigationTitle("Paramètres")
            }
            Button("Déconnexion") {
                parametersViewModel.disconnect(callback: { result in
                    if result {
                        self.appState.moveToAuth = true
                    }
                })
            }.padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color("ButtonLightGradient").opacity(0.5), Color("ButtonDarkGradient").opacity(0.5)]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(80.0)
                .foregroundColor(.black)
                .font(.title2)
            
            Spacer()
                .frame(height: 20)
        }.background(Color.gray.opacity(0.1))
            .popover(isPresented: $showingPopover) {
                Text("Merci de confirmer vos identifiants")
                    .padding()
                    .font(.headline)
                TextField("Adresse email", text: $parametersViewModel.email)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                SecureField("Mot de passe actuel", text: $parametersViewModel.actualPassword)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                SecureField("Nouveau mot de passe", text: $parametersViewModel.password)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                SecureField("Confirmer le mot de passe", text: $parametersViewModel.confirmPassword)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                Button("Valider") {
                    parametersViewModel.reauthenticate(email:parametersViewModel.email, password: parametersViewModel.actualPassword, callback: { result in
                        if result {
                            parametersViewModel.changePassword(password: parametersViewModel.password)
                            self.showingPopover = false
                        }
                    })
                }
            }
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
