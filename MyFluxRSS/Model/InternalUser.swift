//
//  User.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 29/04/2022.
//

import Foundation
import FirebaseFirestoreSwift

class InternalUser: Codable, ObservableObject {
    
    // Create a singleton instance of app user
    static let shared: InternalUser = {
        let instance = InternalUser()
        return instance
    }()
    
    private init() {}
    
    //MARK: - Properties
    @DocumentID var id: String?
    var firstName = ""
    var lastName = ""
    var email = ""
    var password = ""
    var birthday : Date = .init()
    var passwordSecurity = ""
    var userID = ""
}
