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
    
    func connect() {
        authService.connect(userMail: self.userMail, password: self.password)
    }
    
    func keepMeLog() {
        
    }
    
   
}


