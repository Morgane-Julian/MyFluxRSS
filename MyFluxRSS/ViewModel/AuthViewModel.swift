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
    
    @Published public var userMail: String = ""
    @Published public var password: String = ""
    
    func connect() async throws {
        do { try await authService.connect(userMail: userMail, password: password)
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


