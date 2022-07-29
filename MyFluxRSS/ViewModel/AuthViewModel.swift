//
//  ContentViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import Foundation

class AuthViewModel: ObservableObject {
    
    //MARK: - Properties
    
    let authService = AuthService()
    var isSignedIn : Bool {
        return authService.auth.currentUser != nil
    }
    
  @Published var userMail: String = ""
  @Published var password: String = ""
    
    //MARK: - Login and security login functions
    
    func connect() async throws -> Bool {
        do { try await authService.connect(userMail: userMail, password: password)
            return true
        } catch {
            throw error
        }
    }
    
    func isUserAlreadyLog() -> Bool {
        if isSignedIn == true {
            return true
        }
        return false
    }
}


