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
    
    let auth = Auth.auth()
    let user = Auth.auth().currentUser
    var credential: AuthCredential?
    var authError = ""
    var changePasswordError = ""
    var deleteAccountError = ""
    
    //MARK: - Sign in Functions
    
    //Connect user to DB
    func connect(userMail: String, password: String) async throws {
        if auth.currentUser?.email != userMail {
            do { try Auth.auth().signOut() }
            catch { print("already logged out") }
            do {
                _ = try await auth.signIn(withEmail: userMail, password: password)
            } catch {
                self.authError = error.localizedDescription
                throw error
            }
        }
    }
    
    // Add lsiteners from FB for auth persistence
    func addListeners() {
        auth.addStateDidChangeListener() { _, user in
            if let user = user {
                InternalUser.shared.userID = user.uid
            } else {
                print("no user log")
            }
        }
    }
    
    //MARK: - Manage account functions
    
    func reauthenticate(email: String, password: String, callback: @escaping (Bool) -> Void) {
        self.credential = EmailAuthProvider.credential(withEmail: email, password: password)
        if let credential = self.credential {
            user?.reauthenticate(with: credential) { authDataResult, error  in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    callback(true)
                }
            }
        }
    }
    
    func disconnect(callback: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            callback(true)
        }
        catch { print(error.localizedDescription)
        }
    }
    
    func changePassword(password: String) {
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                self.changePasswordError = error?.localizedDescription ?? "Une erreur s'est produite, veuillez réassayer."
            }
        }
    }
    
    func deleteAcount() {
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                self.deleteAccountError = error?.localizedDescription ?? "Une erreur s'est produite, veuillez réassayer."
            }
        }
    }
}
