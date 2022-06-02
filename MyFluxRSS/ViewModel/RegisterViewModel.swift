//
//  RegisterViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 18/03/2022.
//

import Foundation
import Firebase

class RegisterViewModel: ObservableObject {
    var user = InternalUser()
    let auth = Auth.auth()
    var isSignedIn = false
    
    func inscription(callback: (Bool) -> Void) {
        auth.createUser(withEmail: user.email, password: user.password) { authResult, error in
             DispatchQueue.main.async {
                if error != nil {
                    print(error?.localizedDescription ?? "Nos serveurs sont actuellement en maintenance merci de réassayer plus tard.")
                } else {
                    print("Félicitations vous êtes enregistré !")
                    self.isSignedIn = true
                }
            }
        }
        callback(isSignedIn)
    }
    
    
    
    
}
