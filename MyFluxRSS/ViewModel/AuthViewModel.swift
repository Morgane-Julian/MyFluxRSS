//
//  ContentViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import Foundation

class AuthViewModel: ObservableObject {
    
    let authService: AuthService
    
    init(authService: AuthService = AuthService(auth: AuthFirebase())) {
        self.authService = authService
    }
    
    //MARK: - Properties
    
    var isSignedIn : Bool {
        return self.authService.auth.currentUID != nil
    }
    @Published var userMail: String = ""
    @Published var password: String = ""
    
    //MARK: - Functions
    
    // Connect the user
    func connect(callback: @escaping (Bool) -> Void) {
        self.authService.connect(userMail: self.userMail, password: self.password, callback: { success in
            if success {
                callback(true)
            } else {
                callback(false)
            }
        })
    }
    
    //Verify if user already log
    func isUserAlreadyLog() -> Bool {
        if isSignedIn == true {
            return true
        }
        return false
    }
}


