//
//  RegisterService.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 07/08/2022.
//

import Foundation
import Firebase

class RegisterService {
    
    //MARK: - Properties
    let auth = Auth.auth()
    
    //MARK: - Functions
    
    //Create a new user in FB
    func inscription(userMail: String, userPassword: String, callback: @escaping (Bool) -> Void) {
        auth.createUser(withEmail: userMail, password: userPassword) { authResult, error in
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
