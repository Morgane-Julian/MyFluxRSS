//
//  AuthService.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 01/04/2022.
//

import Foundation
import Firebase

class AuthService: ObservableObject {
    
    //MARK: - Properties
    
    var authError = ""
    var changePasswordMessage = ""
    var deleteAccountError = ""
    
    let auth: AuthType
    var currentUID: String? { return auth.currentUID }
    
    // MARK: - Initializer

    init(auth: AuthType = AuthFirebase()) {
        self.auth = auth
    }
    
    //MARK: - Sign in Functions
    
    //Connect user to DB
    func connect(userMail: String, password: String, callback: @escaping (Bool) -> Void) {
        auth.signIn(email: userMail, password: password, callback: { success, error in
            if success {
                callback(true)
            } else {
                callback(false)
                self.authError = error?.localizedDescription ?? "Une erreur s'est produite, veuillez réassayer"
            }
        })
    }
    
    // Add listeners from FB for auth persistence
    func addListeners() {
        auth.isUserConnected()
    }
    
    func inscription(userMail: String, userPassword: String, callback: @escaping (Bool) -> Void) {
        auth.createUser(userMail: userMail, userPassword: userPassword, callback: callback)
        }
    
    //MARK: - Manage account functions
    
    func reauthenticate(email: String, password: String, callback: @escaping (Bool) -> Void) {
            auth.reauthenticate(email: email, password: password, callback: { success in
                if success {
                    callback(true)
                } else {
                    callback(false)
                }
            })
    }
    
    func disconnect(callback: @escaping (Bool) -> Void) {
        auth.signOut(callback: callback)
    }
    
    func changePassword(password: String, callback: @escaping (Bool) -> Void) {
        auth.changePassword(password: password, callback: { success, error in
            if success {
                self.changePasswordMessage = "Le mot de passe a été mis à jour"
                callback(success)
            } else {
                self.changePasswordMessage = "Une erreur s'est produite, veuillez réassayer"
                callback(success)
            }
        })
    }
    
    func deleteAcount(callback: @escaping (Bool) -> Void) {
        auth.deleteAccount(callback: { success, error in
            if success {
                callback(success)
            } else {
                self.deleteAccountError = "Une erreur s'est produite, veuillez réassayer"
                callback(success)
            }
        })
    }
}
