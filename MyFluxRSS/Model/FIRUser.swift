//
//  FIRUser.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 30/07/2022.
//

import Foundation

class FIRUser: ObservableObject {
    
    static let shared: FIRUser = {
        let instance = FIRUser()
        return instance
    }()
    
    var userID = ""
    
    private init() {
        
    }
    
    
}
