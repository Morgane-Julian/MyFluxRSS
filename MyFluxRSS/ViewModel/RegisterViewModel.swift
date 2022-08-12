//
//  RegisterViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 18/03/2022.
//

import Foundation
import Firebase

class RegisterViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var user = InternalUser.shared
    @Published var isSignedIn = false
    
    //MARK: - Register function
    
    //register a new account
    func inscription() {
        AuthService.shared.inscription(userMail: self.user.email, userPassword: self.user.password, callback: { success in
            if success {
                self.isSignedIn = true
            }
        })
    }
}
