//
//  UserTest.swift
//  MyFluxRSSTests
//
//  Created by Morgane Julian on 25/08/2022.
//

import Foundation
@testable import MyFluxRSS

class FakeUsertest {
var id = "1"
var firstName = "JULIAN"
var lastName = "Morgane"
var email = "morgane.julian@gmail.com"
var password = "password"
    var birthday = Date.now
var passwordSecurity = "password"
var userID = "NyeVduglGkQAgldAgG5durdJAer2"
}


class BadUserTest {
    var id = 1
    var firstName = ""
    var lastName = ""
    var email = "morgane.julian@gmail.com"
    var password = "password"
        var birthday = Date.now
    var passwordSecurity = "incorrectPasword"
    var userID = ""
    
}
