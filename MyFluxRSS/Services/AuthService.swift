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
    
    //MARK: - Sign in Functions
    
    //Connect user to DB
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
}
