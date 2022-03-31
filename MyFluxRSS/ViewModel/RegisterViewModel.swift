//
//  RegisterViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 18/03/2022.
//

import Foundation
import Firebase

class RegisterViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var birthday : Date = .init()
    @Published var passwordSecurity = ""
    
    let auth = Auth.auth()
    
    var isSignedIn : Bool {
        return auth.currentUser != nil
    }
    
    func inscription() {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    print("Une erreur s'est produite, veuillez réessayer.")
                } else {
                    print("Félicitations vous êtes enregistré ! Vérifiez vos mails.")
                    
                }
            }
        }
    }
    
}
