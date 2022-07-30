//
//  RegisterViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 18/03/2022.
//

import Foundation
import Firebase

class RegisterViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var user = InternalUser()
    let auth = Auth.auth()
    var isSignedIn = false
    
    //MARK: - Register function
    
    func inscription(callback: @escaping (Bool) -> Void) {
        auth.createUser(withEmail: user.email, password: user.password) { authResult, error in
             DispatchQueue.main.async {
                if error != nil {
                    print(error?.localizedDescription ?? "Nos serveurs sont actuellement en maintenance merci de réassayer plus tard.")
                    callback(false)
                } else {
                    print("Félicitations vous êtes enregistré !")
                    callback(true)
                }
            }
        }
    }
}
