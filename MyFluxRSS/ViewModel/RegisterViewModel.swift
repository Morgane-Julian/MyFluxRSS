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
    var registerService = RegisterService()
    
    //MARK: - Register function
    
    //register a new account
    func inscription() {
        self.registerService.inscription(userMail: self.user.email, userPassword: self.user.password, callback: { success in
            if success {
                self.isSignedIn = true
            }
        })
    }
}
