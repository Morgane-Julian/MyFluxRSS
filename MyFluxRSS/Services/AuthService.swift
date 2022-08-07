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
    let auth = Auth.auth()
//    private var authenticationStateHandler: AuthStateDidChangeListenerHandle?

    //MARK: - Sign in Functions
    func connect(userMail: String, password: String) async throws {
        if auth.currentUser?.email != userMail {
            do { try Auth.auth().signOut() }
            catch { print("already logged out") }
            do {
                _ = try await auth.signIn(withEmail: userMail, password: password)
            } catch {
                throw error
            }
        }
    }
    
    func addListeners() {
        auth.addStateDidChangeListener() { _, user in
            if let user = user {
                FIRUser.shared.userID = user.uid
            } else {
                print("no user log")
            }
        }
        
//        if let handle = authenticationStateHandler {
//            Auth.auth().removeStateDidChangeListener(handle)
//        }
    }
}
