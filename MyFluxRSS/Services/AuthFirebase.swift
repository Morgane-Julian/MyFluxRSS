//
//  AuthFirebase.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 10/08/2022.
//

import Foundation
import Firebase

protocol AuthType {
    var currentUID: String? { get }
    func createUser(userMail: String, userPassword: String, callback: @escaping (Bool) -> Void)
    func signIn(email: String, password: String, callback: @escaping (Bool, Error?) -> Void)
    func signOut(callback: @escaping (Bool) -> Void)
    func isUserConnected()
    func reauthenticate(credential: AuthCredential, callback: @escaping (Bool) -> Void)
    func changePassword(password: String, callback: @escaping (Bool, Error?) -> Void)
    func deleteAccount(callback: @escaping (Bool, Error?) -> Void)
}

final class AuthFirebase: AuthType {
    
    // MARK: - Properties
    var currentUID: String? {
        return Auth.auth().currentUser?.uid
    }
    
    func createUser(userMail: String, userPassword: String, callback: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: userMail, password: userPassword) { authResult, error in
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
    
    func signIn(email: String, password: String, callback: @escaping (Bool, Error?) -> Void) {
        if Auth.auth().currentUser?.email != email {
            do { try Auth.auth().signOut() }
            catch {
                print("Already logged out")
            }
            Auth.auth().signIn(withEmail: email, password: password, completion: { authDataResult, error  in
                if let error = error {
                    print(error.localizedDescription)
                    callback(false, error)
                } else {
                    callback(true, nil)
                }
            })
        }
    }
    
    func signOut(callback: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            callback(true)
        }
        catch {
            print(error.localizedDescription)
            callback(false)
        }
    }
    
    func isUserConnected() {
        Auth.auth().addStateDidChangeListener() { _, user in
            if let user = user {
                InternalUser.shared.userID = user.uid
            } else {
                print("no user log")
            }
        }
    }
    
    func reauthenticate(credential: AuthCredential, callback: @escaping (Bool) -> Void) {
        if let currentUser = Auth.auth().currentUser {
            currentUser.reauthenticate(with: credential) { authDataResult, error  in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    callback(true)
                }
            }
        }
    }
    
    func changePassword(password: String, callback: @escaping (Bool, Error?) -> Void) {
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            guard error != nil else { return }
        }
    }

    func deleteAccount(callback: @escaping (Bool, Error?) -> Void) {
        let user = Auth.auth().currentUser
        user?.delete { error in
            guard error != nil else { return }
        }
    }

   
}

