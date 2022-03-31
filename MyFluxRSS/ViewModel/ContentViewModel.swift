//
//  ContentViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import Foundation
import SwiftUI
import Firebase

class ContentViewModel: ObservableObject {
    @Published public var userMail: String = ""
    @Published public var password: String = ""
    
    let auth = Auth.auth()
    
    var isSignedIn : Bool {
        return auth.currentUser != nil
    }
    
    func connect() {
        auth.signIn(withEmail: userMail, password: password) { result, error in
            DispatchQueue.main.async {
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    //pop-up erreur
                } else {
                    print("success")
                }
            }
        }
    }
    
    func keepMeLog() {
        
    }
}
