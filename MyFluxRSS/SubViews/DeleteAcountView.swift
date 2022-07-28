//
//  AuthPopUp.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 28/07/2022.
//

import SwiftUI

struct DeleteAcountView: View {
    @StateObject var parametersViewModel: ParametersViewModel
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding()
                    
                Text("Nous sommes navrés de te voir partir.")
                    .padding()
                    .font(.headline)
                Text("Merci de confirmer tes identifiants afin de procéder à la suppression de ton compte. Attention cette action est irremédiable la suppression sera définite")
                    .padding()
                    .font(.body)
            
            TextField("Adresse email", text: $parametersViewModel.email)
            SecureField("Mot de passe", text: $parametersViewModel.actualPassword)
                .padding()
            
            Button("Valider") {
                parametersViewModel.reauthenticate(email: parametersViewModel.email, password: parametersViewModel.actualPassword, callback: { result in
                    if result {
                        parametersViewModel.deleteAcount()
                        self.appState.moveToAuth = true
                    }
                })
            }
        }
    }
}

struct DeleteAcountView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (3rd generation)", "iPhone 13 Pro Max"], id: \.self) {
            DeleteAcountView(parametersViewModel: ParametersViewModel())
                .previewDevice(.init(rawValue: $0))
                .previewDisplayName($0)
            //                .preferredColorScheme(.dark)
        }
    }
}
