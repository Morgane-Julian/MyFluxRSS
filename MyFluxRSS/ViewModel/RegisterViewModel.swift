//
//  RegisterViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 18/03/2022.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var birthday : Date = .init()
    @Published var passwordSecurity = ""
    
}
