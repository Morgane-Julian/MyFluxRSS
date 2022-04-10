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
    
    //MARK: - Sign in/out Functions
    func connect(userMail: String, password: String) async throws {
        if auth.currentUser?.email != userMail {
            do { try Auth.auth().signOut() }
            catch { print("already logged out") }
            do {
                _ = try await auth.signIn(withEmail: userMail, password: password)
            } catch {
                throw error
            }
//                DispatchQueue.main.async {
//                    if error != nil {
//                        print(error?.localizedDescription ?? "")
//                        //pop-up erreur
//                    } else {
//                        print("success")
//                    }
//                }
            }
        }
    }
