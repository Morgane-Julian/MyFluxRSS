//
//  AuthService.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 01/04/2022.
//

import Foundation
import Firebase

class AuthService {
    
    //MARK: - Properties
    let auth = Auth.auth()
    
    //pour le keepMeLog
//    let userDefault = UserDefaults.standard
//    let launchedBefore = UserDefaults.standard.bool(forKey: "usersignedin")
    
    //MARK: - Sign in/out Functions
    func connect(userMail: String, password: String) {
        if auth.currentUser?.email != userMail {
            do { try Auth.auth().signOut() }
            catch { print("already logged out") }
            auth.signIn(withEmail: userMail, password: password) { result, error in
                DispatchQueue.main.async {
                    if error != nil {
                        print(error?.localizedDescription ?? "")
                        //pop-up erreur
                    } else {
                        print("success")
                    }
                }
            }
        }
    }
}
