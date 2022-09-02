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
    func reauthenticate(email: String, password: String, callback: @escaping (Bool) -> Void)
    func changePassword(password: String, callback: @escaping (Bool, Error?) -> Void)
    func deleteAccount(callback: @escaping (Bool, Error?) -> Void)
}

final class AuthFirebase: AuthType {
    
    // MARK: - Properties
    var currentUID: String? {
        return Auth.auth().currentUser?.uid
    }
    
    //MARK: - Firebase Functions
    //Create a new user in firebase
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
    
    //connect an existing user to firebase
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
    
    //signout an existing user
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
    
    //test if a user is already log
    func isUserConnected() {
        Auth.auth().addStateDidChangeListener() { _, user in
            if let user = user {
                InternalUser.shared.userID = user.uid
            } else {
                print("no user log")
            }
        }
    }
    
    // reauthentication of user before managing profile
    func reauthenticate(email: String, password: String, callback: @escaping (Bool) -> Void) {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
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
    
    //change the password for the current user
    func changePassword(password: String, callback: @escaping (Bool, Error?) -> Void) {
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            guard error != nil else { return }
        }
    }
    
    //delete account of the current user
    func deleteAccount(callback: @escaping (Bool, Error?) -> Void) {
        let user = Auth.auth().currentUser
        user?.delete { error in
            guard error != nil else { return }
        }
    }
}

