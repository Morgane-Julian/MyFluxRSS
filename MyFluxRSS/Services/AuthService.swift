//
//  AuthService.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 01/04/2022.
//

import Foundation
import Firebase

class AuthService: ObservableObject {
    
    //Create a singleton instance of article repository
    static let shared: AuthService = {
        let instance = AuthService()
        return instance
    }()
    
    //MARK: - Properties
    
    var credential: AuthCredential?
    var authError = ""
    var changePasswordError = ""
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
            if error != nil {
                self.authError = error?.localizedDescription ?? "Une erreur s'est produite, veuillez réassayer"
            } else {
                callback(success)
            }
        })
    }
    
    // Add lsiteners from FB for auth persistence
    func addListeners() {
        auth.isUserConnected()
    }
    
    //MARK: - Manage account functions
    
    func reauthenticate(email: String, password: String, callback: @escaping (Bool) -> Void) {
        self.credential = EmailAuthProvider.credential(withEmail: email, password: password)
        if let credential = self.credential {
            auth.reauthenticate(credential: credential, callback: { success in
                if success {
                    callback(true)
                } else {
                    callback(false)
                }
            })
        }
    }
    
    func disconnect(callback: @escaping (Bool) -> Void) {
        auth.signOut(callback: callback)
    }
    
    func changePassword(password: String) {
        auth.changePassword(password: password, callback: { success, error in
            if success {
                self.changePasswordError = "Le mot de passe a été mis à jour"
            } else {
                self.changePasswordError = error?.localizedDescription ?? "Une erreur s'est produite, veuillez réassayer"
                return
            }
        })
    }
    
    func deleteAcount() {
        auth.deleteAccount(callback: { success, error in
            guard success else {
                self.deleteAccountError = error?.localizedDescription ?? "Une erreur s'est produite, veuillez réassayer"
                return
            }
        })
    }
}
