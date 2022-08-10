//
//  ContentViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import Foundation

class AuthViewModel: ObservableObject {
    
    //MARK: - Properties
    
    var authService = AuthService()
    var isSignedIn : Bool {
        return self.authService.auth.currentUser?.getIDToken() != nil
    }
    
    @Published var userMail: String = ""
    @Published var password: String = ""
    
    //MARK: - Functions
    
    // Connect the user
    func connect() async throws -> Bool {
        do { try await self.authService.connect(userMail: userMail, password: password)
            return true
        } catch {
            throw error
        }
    }
    
    //Verify if user already log
    func isUserAlreadyLog() -> Bool {
        if isSignedIn == true {
            return true
        }
        return false
    }
}


