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
    
    func connect() {
        Auth.auth().signIn(withEmail: userMail, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
    
    func keepMeLog() {
        
    }
}
